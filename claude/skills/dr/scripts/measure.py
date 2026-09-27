# /// script
# requires-python = ">=3.11"
# dependencies = ["numpy"]
# ///
"""Download YouTube uploads and measure how compressed each one is.

    uv run measure.py --dir WORK TARGET [TARGET ...] [--jobs 4]
    uv run measure.py --dir WORK            # reprint the ranking (incl. chapters.py --dr results)

TARGET: a video id/URL, a playlist id/URL (PL..., OLAK5uy...), or several videos joined with '+'
(an album uploaded as Side 1 + Side 2: 'ID1+ID2').

Per upload: DR (TT DR-meter per piece, duration-weighted; pieces = playlist entries, else the parts
between silent gaps, min 60 s), whole-program DR, EBU R128 loudness + LRA, peak, the level inside
the gaps between tracks (digital silence vs noise), and warnings (mixed masters, playlist entries
that aren't album tracks). Pieces are not songs on segue albums, so rank the finalists with
chapters.py --dr, which measures every upload on the same song boundaries.

Audio + per-window data stay in WORK for chapters.py; delete WORK when done. Results merge into
WORK/results.json (rerun with more targets any time).
"""
import argparse, concurrent.futures as cf, json, os, re, sys
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import (run, fmt, stream_windows, split_tracks, find_gaps, track_dr, dr_over, duration,
                    ebur, load_results, save_results)

# "Live" alone is a song-title word ("Live To Win"): only live-*recording* phrasings count
NOT_ALBUM = re.compile(r"[\(\[]\s*live\b|\blive (?:at|in|from|version|recording)\b|[-–—]\s*live\s*$|concert|\btour\b"
                       r"|film|video edit|single edit|radio edit|\bedit\b|promo|trailer"
                       r"|competition|q&a|interview|teaser|documentary|behind the|making of|animation|short", re.I)

def is_playlist(t):
    return "list=" in t or re.fullmatch(r"(PL|OLAK5uy|UU|FL|RD)[\w-]{10,}", t) is not None

def pl_id(t):
    m = re.search(r"list=([\w-]+)", t)
    return m.group(1) if m else t

def vid_id(t):
    m = re.search(r"(?:v=|youtu\.be/|shorts/)([\w-]{11})", t)
    return m.group(1) if m else t

def official(channel, verified, pid=""):
    return bool(verified) or pid.startswith("OLAK5uy") or bool(re.search(r"official|- topic|vevo", channel or "", re.I))

TS = re.compile(r"(?<![\d:])(?:(\d{1,2}):)?(\d{1,2}):(\d{2})(?![\d:])")

def parse_timestamps(desc):
    """'00:00 Song' / 'Song - 0:00' / '1. Song (2:46)' lines -> [{t, title}] if they form a tracklist."""
    out = []
    for line in desc.splitlines():
        m = TS.search(line)
        if not m: continue
        h, mi, s = m.groups()
        title = line[: m.start()] + " " + line[m.end():]
        title = re.sub(r"^[\s\W\d]*?(?=[^\W\d])", "", title, count=1)
        title = re.sub(r"[\s\-–—|:()\[\]]+$", "", title).strip()
        out.append({"t": int(h or 0) * 3600 + int(mi) * 60 + int(s), "title": title})
    if len(out) < 3 or out[0]["t"] > 30 or any(b["t"] <= a["t"] for a, b in zip(out, out[1:])):
        return []
    return out

def fetch_video(vid, work):
    base = os.path.join(work, vid)
    r = run(["yt-dlp", "--no-warnings", "-q", "-f", "251/bestaudio", "--write-info-json",
             "-o", base + ".%(ext)s", "--", vid])
    files = [base + e for e in (".webm", ".m4a", ".opus", ".mp4") if os.path.exists(base + e)]
    info = json.load(open(base + ".info.json")) if os.path.exists(base + ".info.json") else {}
    if not files:
        return {"id": vid, "error": (r.stderr.strip().splitlines() or ["download failed"])[-1]}
    if info.get("chapters") and len(info["chapters"]) >= 3:
        times, src = [{"t": c["start_time"], "title": c.get("title", "")} for c in info["chapters"]], "chapters"
    else:
        times = parse_timestamps(info.get("description") or "")
        src = "description" if times else None
    url = f"https://www.youtube.com/watch?v={vid}"
    return {"kind": "video", "id": vid, "url": url, "title": info.get("title"),
            "channel": info.get("channel") or info.get("uploader"),
            "official": official(info.get("channel"), info.get("channel_is_verified")),
            "upload_date": info.get("upload_date"), "files": files, "parts": [{"id": vid, "url": url}],
            "timestamps": times, "timestamps_source": src}

def fetch(target, work):
    if "+" in target:  # album in several videos (Side 1 + Side 2), measured back to back
        vs = [fetch_video(vid_id(t), work) for t in target.split("+")]
        bad = [v for v in vs if "error" in v]
        if bad: return {"id": target, "error": bad[0]["error"]}
        return {"kind": "sides", "id": target, "url": vs[0]["url"], "title": " + ".join(v["title"] or "" for v in vs),
                "channel": vs[0]["channel"], "official": all(v["official"] for v in vs),
                "files": [f for v in vs for f in v["files"]], "parts": [p for v in vs for p in v["parts"]],
                "timestamps": [], "timestamps_source": None}
    if not is_playlist(target):
        return fetch_video(vid_id(target), work)
    pid = pl_id(target)
    d = os.path.join(work, pid)
    os.makedirs(d, exist_ok=True)
    url = f"https://www.youtube.com/playlist?list={pid}"
    info = json.loads(run(["yt-dlp", "--no-warnings", "--flat-playlist", "-J", url]).stdout or "{}")
    run(["yt-dlp", "--no-warnings", "-q", "-f", "251/bestaudio", "-o", os.path.join(d, "%(playlist_index)03d_%(id)s.%(ext)s"), url])
    got = {m.group(1): os.path.join(d, f) for f in sorted(os.listdir(d)) if (m := re.fullmatch(r"\d{3}_([\w-]{11})\.\w+", f))}
    entries = [e for e in (info.get("entries") or []) if e.get("id") in got]  # skip unavailable ones
    if not entries: return {"id": pid, "error": "no playlist entries could be downloaded"}
    files = [got[e["id"]] for e in entries]
    times, t = [], 0.0
    for e, f in zip(entries, files):  # exact boundaries from the files themselves
        times.append({"t": round(t, 2), "title": e.get("title") or ""}); t += duration(f)
    ch = info.get("channel") or info.get("uploader") or (entries[0].get("channel") if entries else None)
    return {"kind": "playlist", "id": pid, "url": url, "title": info.get("title"), "channel": ch,
            "official": official(ch, info.get("channel_is_verified"), pid), "files": files,
            "parts": [{"id": e["id"], "url": f"https://www.youtube.com/watch?v={e['id']}&list={pid}"} for e in entries],
            "entries": [{"id": e["id"], "title": e.get("title"), "duration": e.get("duration")} for e in entries],
            "n_tracks": len(entries), "timestamps": times, "timestamps_source": "playlist"}

def analyse(r, work):
    got = stream_windows(r["files"], os.path.join(work, f".{r['id']}.ffmpeg.log"))
    if got is None: return {"error": "no audio decoded"}
    ms, pk, log = got
    np.savez(os.path.join(work, f"{r['id']}.win.npz"), ms=ms, pk=pk)  # for chapters.py --dr
    mono_db = 10 * np.log10(ms.mean(1) + 1e-24)
    if r["kind"] == "playlist":
        edges = np.round(np.array([e["t"] for e in r["timestamps"]] + [len(ms) / 10]) * 10).astype(int)
        segs = [[a, b] for a, b in zip(edges, edges[1:]) if b > a]
    else:
        segs = split_tracks(mono_db)
    dr, pieces = dr_over(ms, pk, segs)
    whole, _ = track_dr(ms, pk)

    notes = []
    if len(pieces) >= 3:  # one piece far louder than the rest = a different master stitched in
        med = float(np.median([t["level"] for t in pieces]))
        hot = [(i + 1, t["level"] - med) for i, t in enumerate(pieces) if t["level"] - med > 3]
        if hot: notes.append("mixed masters? " + ", ".join(f"piece {i} +{d:.0f} dB" for i, d in hot))
    if r["kind"] == "playlist":
        short = [e for e in r["entries"] if (e.get("duration") or 999) < 60]
        odd = [e["title"] for e in r["entries"] if NOT_ALBUM.search(e.get("title") or "")]
        if short: notes.append(f"{len(short)} entries under 60 s")
        if odd: notes.append("non-album entries? " + "; ".join(odd[:4]) + (" …" if len(odd) > 4 else ""))

    # level inside the gaps at piece boundaries (a stop inside a song doesn't count); edges skipped
    inner = np.zeros(len(mono_db), bool)
    bounds = [a for a, _ in segs[1:]]
    for g0, g1 in find_gaps(mono_db):
        if any(g0 - 10 <= b <= g1 + 10 for b in bounds): inner[g0:g1] = True
    inner[:30] = inner[-30:] = False
    floor = float(np.percentile(mono_db[inner], 10)) if inner.sum() >= 4 else None
    if floor is None: source = "no gaps to judge"
    elif floor <= -90: source = "digital silence"
    elif floor <= -38: source = "noise in gaps"
    else: source = "noisy/short gaps"
    return {"dr": round(dr, 2) if dr else None, "dr_whole": round(whole, 2) if whole else None,
            "n_pieces": len(pieces), "pieces": pieces, "notes": notes, "lufs": ebur(log, "I"),
            "lra": ebur(log, "LRA"), "peak": ebur(log, "Peak"),
            "floor": round(max(floor, -240.0), 1) if floor is not None else None, "source": source,
            "seconds": round(len(ms) / 10, 1)}

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("targets", nargs="*", help="none: just reprint the ranking in WORK/results.json")
    ap.add_argument("--dir", required=True, help="work dir: audio, window data and results.json are kept here")
    ap.add_argument("--jobs", type=int, default=4)
    a = ap.parse_args()
    os.makedirs(a.dir, exist_ok=True)

    def one(t):
        r = fetch(t, a.dir)
        if "error" not in r: r.update(analyse(r, a.dir))
        return r

    with cf.ThreadPoolExecutor(a.jobs) as ex:
        new = list(ex.map(one, a.targets))
    old = {r["id"]: r for r in load_results(a.dir)}
    for r in new:  # a re-measured upload drops its old chapters.py results
        old[r["id"]] = r
    results = save_results(a.dir, list(old.values()))

    f = lambda v, w, p=1: f"{v:{w}.{p}f}" if v is not None else " " * (w - 1) + "-"
    print(f"{'#':>2s} {'DR':>5s} {'whole':>5s} {'n':>3s} {'LUFS':>6s} {'LRA':>4s} {'peak':>5s} {'floor':>6s}  "
          f"{'source':16s} {'len':>7s} {'ts':11s} {'DRalign':>7s} {'speed':>7s}  id — title — channel")
    for i, r in enumerate(results, 1):
        if "error" in r:
            print(f"{'-':>2s} ERROR {r['id']} — {r['error']}"); continue
        ts = r.get("timestamps_source") or "-"
        tag = ("[OFFICIAL] " if r.get("official") else "") + (f"[playlist, {r.get('n_tracks')}] " if r["kind"] == "playlist" else "") \
            + ("[sides] " if r["kind"] == "sides" else "")
        sp = f"{r['speed_pct']:+.2f}%" if r.get("speed_pct") is not None else "-"
        print(f"{i:2d} {f(r['dr'], 5)} {f(r['dr_whole'], 5)} {r['n_pieces']:3d} {f(r['lufs'], 6)} {f(r['lra'], 4)} "
              f"{f(r['peak'], 5)} {f(r['floor'], 6)}  {r['source']:16s} {fmt(r['seconds']):>7s} {ts:11s} "
              f"{f(r.get('dr_aligned'), 7)} {sp:>7s}  {r['id']} — {tag}{r['title']} — {r['channel']}")
        for n in r.get("notes") or []: print(f"{'':>10s}!! {n}")
        for n in r.get("align_notes") or []: print(f"{'':>10s}!! {n}")
    print(f"\nresults: {os.path.join(a.dir, 'results.json')}")

if __name__ == "__main__":
    main()
