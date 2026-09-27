# /// script
# requires-python = ">=3.11"
# dependencies = ["numpy"]
# ///
"""Verify an upload against a reference and find where each song starts; optionally measure its
DR on those song boundaries (so every upload is compared on identical tracks).

    uv run chapters.py --dir WORK TARGET [TARGET ...] [--ref REF_ID] [--dr]
    uv run chapters.py --dir WORK TARGET --peek 1560 1576     # loudness strip, 0.25 s steps

Needs WORK/results.json + audio from measure.py. Without --ref, the reference is picked from
results.json: official first, then exact boundaries (playlist) > chapters > description timestamps,
skipping playlists flagged as containing non-album entries. Use the SAME --ref for every upload
you compare with --dr.

Method: every 5 s of the target (10 s window) is matched against the whole reference; a Viterbi
pass picks, per probe, the candidate position that keeps consecutive probes advancing steadily
through the reference, so repeated/periodic sounds are placed by context. The path splits into
runs (continuous stretches); each run's line fit gives the playback speed and maps every reference
song start into target time. A silent gap ending within 2 s snaps the start to the exact onset.

Reported per target: song table (clickable), speed vs reference (a digital copy of the same master
is ±0.00%; vinyl/tape transfers are typically off by 0.2-2.5%), coverage (share of the upload that
follows the reference forwards; low = reversed/altered/different content), order, missing songs.
"""
import argparse, os, sys
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import (ASR, fmt, decode_mono, decode_upload, feat, align, runs, onsets, clean_titles,
                    track_dr, load_results, save_results)

def pick_ref(res):
    """Official first, then exact boundaries (playlist) > chapters > description timestamps. Playlists
    flagged with non-album entries only as a last resort (they may hold video edits / live takes)."""
    rank = {"playlist": 0, "chapters": 1, "description": 2}
    flagged = lambda r: any("non-album" in n or "under 60 s" in n for n in r.get("notes") or [])
    pool = [r for r in res.values() if r.get("timestamps")]
    if not pool: return None
    return min(pool, key=lambda r: (flagged(r), not r.get("official"), rank.get(r.get("timestamps_source"), 9), -len(r["timestamps"])))

def ref_tracks(ref, rx):
    """Reference song starts (s) + titles. Written timestamps are snapped to the reference's own
    onsets within 2.5 s; playlist boundaries are exact already."""
    ts = ref["timestamps"]
    starts = [e["t"] for e in ts]
    if ref["timestamps_source"] != "playlist":
        ron = onsets(rx)
        if len(ron):
            starts = [float(ron[np.argmin(np.abs(ron - t))]) if np.min(np.abs(ron - t)) <= 2.5 else t for t in starts]
    return list(zip(starts, clean_titles([e["title"] for e in ts])))

def link(tgt, start):
    """Clickable time: into the right video for playlists / side uploads (chosen by the exact start,
    then floored half a second early so the first note isn't clipped)."""
    starts = tgt.get("_file_starts") or [0.0]
    k = max(i for i, s in enumerate(starts) if s <= start + 0.05)
    part = tgt["parts"][k] if tgt.get("parts") and k < len(tgt["parts"]) else {"url": tgt["url"]}
    local = max(0, int(start - starts[k] - 0.5))
    t = max(0, int(start - 0.5))
    sep = "&" if "?" in part["url"] else "?"
    label = fmt(t) if len(starts) == 1 else f"{fmt(t)} (part {k + 1} @ {fmt(local)})"
    return f"[{label}]({part['url']}{sep}t={local}s)"

def analyse(tgt, ref, rx, rf, tracks, do_dr, work):
    tx, fstarts = decode_upload(tgt)
    tgt["_file_starts"] = fstarts
    tdur, rdur = len(tx) / ASR, len(rx) / ASR
    path = align(feat(tx), rf)
    rs = [r for r in runs(path) if r["n"] >= 3]  # >= 15 s of steady match
    ends = [s for s, _ in tracks[1:]] + [rdur]
    ton = onsets(tx)
    # candidate placements per song: runs covering its start, else runs beginning just after it
    # (a reordered upload). Several candidates = a sound that recurs (the heartbeat that opens and
    # closes an album): take the one whose offset agrees with an unambiguous neighbouring song.
    cands = []
    for s, _ in tracks:
        e = ends[len(cands)]
        pool = [r for r in rs if r["r0"] - 2 <= s <= r["r_last"] + 2] or [r for r in rs if s < r["r0"] <= min(s + 15, e)]
        cands.append([(max(0.0, r["a"] + r["b"] * s), r) for r in pool])
    sure = {k: c[0][0] - tracks[k][0] for k, c in enumerate(cands) if len(c) == 1}
    rows, missing = [], []
    for k, ((s, title), e, c) in enumerate(zip(tracks, ends, cands)):
        if not c:
            missing.append((k + 1, title)); continue
        near = [sure[j] for j in (k - 1, k + 1) if j in sure]
        if len(c) > 1 and near:
            est, r = min(c, key=lambda x: min(abs(x[0] - s - o) for o in near))
        else:
            est, r = max(c, key=lambda x: x[1]["n"])
        start, how = est, "aligned"
        if len(ton):
            d = np.abs(ton - est)
            if d.min() <= 2: start, how = float(ton[np.argmin(d)]), "gap"
        rows.append({"start": start, "n": k + 1, "title": title, "how": how, "score": r["score"],
                     "ref_len": e - s})
    rows.sort(key=lambda x: x["start"])

    mask = np.zeros(int(tdur) + 1, bool)
    for r in rs: mask[int(max(0, r["t0"])): int(min(tdur, r["t1"]))] = True
    coverage = mask.mean() if tdur else 0
    w = sum(r["n"] for r in rs)
    speed = (sum(r["n"] / r["b"] for r in rs) / w - 1) * 100 if w else None  # b<1: plays fast
    unmatched, prev = [], 0.0
    for r in sorted(rs, key=lambda r: r["t0"]) + [{"t0": tdur, "t1": tdur}]:
        if r["t0"] - prev >= 30 and prev > 10 and r["t0"] < tdur - 10: unmatched.append((prev, r["t0"]))
        prev = max(prev, r["t1"])

    out = {"ref": ref["id"], "coverage": round(coverage, 3), "speed_pct": round(speed, 2) if speed is not None else None,
           "songs": [{k: v for k, v in x.items() if k != "ref_len"} for x in rows], "align_notes": []}
    notes = out["align_notes"]
    if coverage < 0.8: notes.append(f"only {coverage:.0%} of the upload follows the reference: reversed, altered or different content?")
    if missing: notes.append("missing: " + ", ".join(f"{n}. {t}" for n, t in missing))
    if [x["n"] for x in rows] != sorted(x["n"] for x in rows): notes.append("plays songs out of album order")
    if len(unmatched) <= 3:
        for t0, t1 in unmatched: notes.append(f"unmatched audio {fmt(t0)}–{fmt(t1)} (not in reference)")
    else:
        notes.append(f"{len(unmatched)} unmatched stretches, {sum(b - a for a, b in unmatched) / 60:.0f} min not in reference")
    if speed is not None and abs(speed) >= 1.5: notes.append(f"plays {speed:+.1f}% vs reference: audibly off pitch")

    if do_dr:
        d = dr_on(rows, tgt, work, tdur, speed or 0.0)
        if d is not None: out["dr_aligned"] = d
    return out, rows

def dr_on(rows, tgt, work, tdur, speed=0.0):
    """Per-song DR on the given song starts (each song runs to the next one's start)."""
    npz = os.path.join(work, f"{tgt['id']}.win.npz")
    if not os.path.exists(npz): return None
    z = np.load(npz); ms, pk = z["ms"], z["pk"]
    vals = []
    for i, x in enumerate(rows):
        end = rows[i + 1]["start"] if i + 1 < len(rows) else min(tdur, x["start"] + x["ref_len"] * (1 - speed / 100))
        a, b = int(round(x["start"] * 10)), min(len(ms), int(round(end * 10)))
        d, _ = track_dr(ms[a:b], pk[a:b])
        x["dr"] = round(d, 2) if d is not None else None
        if d is not None: vals.append(d)
    return round(float(np.mean(vals)), 2) if vals else None  # DR-database style: plain mean over songs

def self_rows(tgt, tracks, tdur, do_dr, work):
    """The reference measured on its own song boundaries."""
    tgt["_file_starts"] = [e["t"] for e in tgt["timestamps"]] if tgt["timestamps_source"] == "playlist" else [0.0]
    ends = [s for s, _ in tracks[1:]] + [tdur]
    rows = [{"start": s, "n": k + 1, "title": t, "how": "own", "score": 1.0, "ref_len": e - s}
            for k, ((s, t), e) in enumerate(zip(tracks, ends))]
    out = {"ref": tgt["id"], "coverage": 1.0, "speed_pct": 0.0, "songs": rows, "align_notes": ["is the reference"]}
    if do_dr:
        d = dr_on(rows, tgt, work, tdur)
        if d is not None: out["dr_aligned"] = d
    return out, rows

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("targets", nargs="+")
    ap.add_argument("--dir", required=True)
    ap.add_argument("--ref")
    ap.add_argument("--dr", action="store_true", help="measure DR per song on the aligned boundaries")
    ap.add_argument("--peek", nargs=2, type=float, metavar=("T0", "T1"))
    a = ap.parse_args()
    res = {r["id"]: r for r in load_results(a.dir) if "files" in r}

    if a.peek:
        t0, t1 = a.peek
        x = decode_mono(res[a.targets[0]]["files"][0], t0, t1 - t0)
        h = ASR // 4; n = len(x) // h
        e = 20 * np.log10(np.sqrt(np.mean(x[: n * h].reshape(n, h).astype(np.float64) ** 2, axis=1)) + 1e-9)
        for i in range(0, n, 4):
            print(f"{fmt(t0 + i / 4)}.{int((t0 + i / 4) * 100) % 100:02d}  " + " ".join(f"{v:6.1f}" for v in e[i:i + 4]))
        return

    ref = res[a.ref] if a.ref else pick_ref(res)
    if ref is None: sys.exit("no usable reference with track times in results.json: measure the official release, or pass --ref")
    rx, _ = decode_upload(ref)
    rf = feat(rx)
    tracks = ref_tracks(ref, rx)
    print(f"reference: {ref['id']} — {ref['title']} ({len(tracks)} songs from {ref['timestamps_source']})")
    for n in ref.get("notes") or []:
        if "non-album" in n or "under 60 s" in n: print(f"!! reference is flagged ({n}): check its song list, or pass --ref")

    for tid in a.targets:
        tgt = res[tid]
        if tid == ref["id"]:
            out, rows = self_rows(tgt, tracks, len(rx) / ASR, a.dr, a.dir)
        else:
            out, rows = analyse(tgt, ref, rx, rf, tracks, a.dr, a.dir)
        tgt.update(out)
        print(f"\n== {tid} — {tgt['title']}")
        sp = f"{out['speed_pct']:+.2f}%" if out["speed_pct"] is not None else "?"
        print(f"coverage {out['coverage']:.0%}   speed {sp} vs reference" + (f"   DR on song boundaries: {out['dr_aligned']:.1f}" if out.get("dr_aligned") else ""))
        for n in out["align_notes"]: print("!! " + n)
        if tgt.get("timestamps") and tgt.get("timestamps_source") != "playlist":
            own = np.array([e["t"] for e in tgt["timestamps"]])
            found = np.array([x["start"] for x in rows])
            off = [float(np.min(np.abs(found - t))) for t in own] if len(found) else []
            bad = sum(o > 6 for o in off)
            print(f"upload's own timestamps ({tgt['timestamps_source']}): " +
                  ("agree" if off and not bad and len(own) == len(found) else f"{bad} of {len(own)} off by > 6 s, {len(found)} songs found"))
        print("\n| Time | Song | Album # | how |" + (" DR |" if a.dr else ""))
        print("|---|---|---|---|" + ("---|" if a.dr else ""))
        for x in rows:
            print(f"| {link(tgt, x['start'])} | {x['title']} | {x['n']} | {x['how']} {x['score']:.2f} |" +
                  ((f" {x['dr']:.1f} |" if x.get("dr") is not None else " - |") if a.dr else ""))
        tgt.pop("_file_starts", None)
    save_results(a.dir, list({**{r["id"]: r for r in load_results(a.dir)}, **res}.values()))

if __name__ == "__main__":
    main()
