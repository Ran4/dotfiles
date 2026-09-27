"""Shared by measure.py and chapters.py (imported, not run)."""
import json, os, re, subprocess, unicodedata
import numpy as np

SR = 48000  # YouTube's opus is 48 kHz natively; DR and loudness are measured at this rate
WIN = SR // 10  # 100 ms analysis windows; a DR block is 30 of them (3 s)
ASR, FPS = 8000, 20  # alignment: 8 kHz mono, 20 spectral frames per second

def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)

def fmt(t):
    t = max(0, int(t))
    return f"{t//3600}:{t%3600//60:02d}:{t%60:02d}" if t >= 3600 else f"{t//60}:{t%60:02d}"

def norm_words(s):
    """'M̲otö̲rhea̲d', '𝐀𝐜𝐞' -> ['motorhead'], ['ace']: NFKD folds styled letters, drop combining marks."""
    s = "".join(c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c))
    return re.sub(r"[^a-z0-9]+", " ", s.lower()).split()

def load_results(work):
    p = os.path.join(work, "results.json")
    return json.load(open(p)) if os.path.exists(p) else []

def save_results(work, results):
    results = sorted(results, key=lambda r: (-(r.get("dr_aligned") or r.get("dr") or -99), r.get("lufs") or 0))
    json.dump(results, open(os.path.join(work, "results.json"), "w"), ensure_ascii=False, indent=1)
    return results

# ---------- DR / level windows ----------

def track_dr(ms, pk):
    """TT DR meter on one track from 100 ms windows (mean square, peak; per channel): 3 s blocks;
    20*log10(2nd-highest block peak / RMS of the loudest 20% of blocks), averaged over channels.
    Returns (DR, loud RMS in dBFS) or (None, None) if shorter than two blocks."""
    nb = len(ms) // 30
    if nb < 2: return None, None
    bms = ms[: nb * 30].reshape(nb, 30, 2).mean(1)
    bpk = pk[: nb * 30].reshape(nb, 30, 2).max(1)
    rms = np.sqrt(2 * bms)
    dr, lvl = [], []
    for c in range(2):
        top = np.sqrt(np.mean(np.sort(rms[:, c])[::-1][: max(1, int(round(0.2 * nb)))] ** 2))
        dr.append(20 * np.log10(max(np.sort(bpk[:, c])[-2], 1e-9) / max(top, 1e-12)))
        lvl.append(20 * np.log10(max(top, 1e-12)))
    return float(np.mean(dr)), float(np.mean(lvl))

def dr_over(ms, pk, bounds):
    """Album DR over [start, end) window ranges: per-track DR, averaged weighted by duration
    (short fragments must not swing it). Returns (album DR, [per-track dicts])."""
    tracks = []
    for a, b in bounds:
        d, lvl = track_dr(ms[a:b], pk[a:b])
        if d is not None:
            tracks.append({"start": round(a / 10, 1), "len": round((b - a) / 10, 1), "dr": round(d, 2), "level": round(lvl, 1)})
    if not tracks: return None, []
    w = np.array([t["len"] for t in tracks])
    return float(np.sum(w * [t["dr"] for t in tracks]) / w.sum()), tracks

def find_gaps(mono_db, below=20, min_win=4, merge_win=20):
    """Silent gaps as [start, end) window indices: >= 0.4 s, `below` dB under the loud level (90th pct),
    merged when < 2 s apart."""
    low = mono_db < np.percentile(mono_db, 90) - below
    gaps, i = [], 0
    while i < len(low):
        if low[i]:
            j = i
            while j < len(low) and low[j]: j += 1
            if j - i >= min_win:
                if gaps and i - gaps[-1][1] < merge_win: gaps[-1][1] = j
                else: gaps.append([i, j])
            i = j
        else: i += 1
    return gaps

def split_tracks(mono_db, min_len=600):
    """[start, end) windows of the pieces between silent gaps; pieces under min_len windows (60 s)
    are merged into a neighbour (stops inside songs, sound-effect intros, lead-in groove)."""
    starts = [0] + [g1 for _, g1 in find_gaps(mono_db) if g1 < len(mono_db)]
    bounds = sorted(set(starts)) + [len(mono_db)]
    merged = []
    for a, b in zip(bounds, bounds[1:]):
        if merged and (b - a < min_len or merged[-1][1] - merged[-1][0] < min_len): merged[-1][1] = b
        else: merged.append([a, b])
    return merged

def duration(f):
    out = run(["ffprobe", "-v", "quiet", "-show_entries", "format=duration", "-of", "csv=p=0", f]).stdout
    try: return float(out.strip())
    except ValueError: return 0.0

def _read_exact(f, n):
    buf = bytearray()
    while len(buf) < n:
        chunk = f.read(n - len(buf))
        if not chunk: break
        buf += chunk
    return bytes(buf)

def stream_windows(files, err_path):
    """Decode files back to back once. Returns per-100 ms-window arrays: mean square (n,2) and
    peak (n,2), plus ffmpeg's EBU R128 log text."""
    ins, pre = [], []
    for i, f in enumerate(files):
        ins += ["-i", f]
        pre.append(f"[{i}:a]aresample={SR},aformat=sample_fmts=flt:channel_layouts=stereo[a{i}]")
    graph = ";".join(pre) + ";" + "".join(f"[a{i}]" for i in range(len(files))) + \
        f"concat=n={len(files)}:v=0:a=1,ebur128=framelog=verbose:peak=true[out]"
    cmd = ["ffmpeg", "-nostdin", "-nostats", "-hide_banner", *ins, "-filter_complex", graph,
           "-map", "[out]", "-f", "f32le", "-"]
    ms, pk = [], []
    chunk = 3 * SR * 2 * 4
    with open(err_path, "w") as err:
        p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=err)
        while True:
            b = _read_exact(p.stdout, chunk)
            nwin = len(b) // (WIN * 8)
            if nwin:
                x = np.frombuffer(b[: nwin * WIN * 8], dtype=np.float32).reshape(nwin, WIN, 2).astype(np.float64)
                ms.append(np.mean(x ** 2, axis=1)); pk.append(np.max(np.abs(x), axis=1))
            if len(b) < chunk: break
        p.wait()
    log = open(err_path).read()
    if not ms: return None
    return np.concatenate(ms), np.concatenate(pk), log

def ebur(log, key):
    m = re.findall(rf"^\s+{key}:\s+(-?[\d.]+)", log, re.M)
    return float(m[-1]) if m else None

# ---------- alignment ----------

def decode_mono(path, t0=None, dur=None):
    cmd = ["ffmpeg", "-v", "quiet", "-nostdin"]
    if t0 is not None: cmd += ["-ss", str(t0)]
    if dur is not None: cmd += ["-t", str(dur)]
    cmd += ["-i", path, "-f", "f32le", "-ac", "1", "-ar", str(ASR), "-"]
    return np.frombuffer(subprocess.run(cmd, capture_output=True).stdout, dtype=np.float32)

def decode_upload(r):
    """All of an upload's files back to back at 8 kHz mono; returns audio and each file's start (s)."""
    parts, starts, t = [], [], 0.0
    for f in r["files"]:
        x = decode_mono(f)
        parts.append(x); starts.append(t); t += len(x) / ASR
    return np.concatenate(parts), starts

_BANDS = {}

def feat(x):
    """Log-spectrum in 30 sixth-octave bands, 120 Hz-4 kHz (100 ms frames, 50 ms hop), per-frame
    mean-removed and unit-normalised. Octave-spaced bands keep a vinyl rip playing 2% fast (and so
    2% sharp) in the same bands as the reference."""
    n_fft, h = ASR // 10, ASR // FPS
    n = (len(x) - n_fft) // h + 1
    if n <= 0: return np.zeros((0, 30))
    if n_fft not in _BANDS:
        freqs = np.fft.rfftfreq(n_fft, 1 / ASR)
        edges = 120 * 2 ** (np.arange(31) / 6)
        _BANDS[n_fft] = np.array([np.searchsorted(freqs, e) for e in edges])
    idx = _BANDS[n_fft]
    fr = np.lib.stride_tricks.sliding_window_view(x, n_fft)[::h][:n] * np.hanning(n_fft)
    P = np.abs(np.fft.rfft(fr, axis=1)) ** 2
    S = np.add.reduceat(P, idx[:-1], axis=1)[:, :30]
    S = np.log(S + 1e-9); S -= S.mean(1, keepdims=True)
    return S / (np.linalg.norm(S, axis=1, keepdims=True) + 1e-9)

def align(tf, rf, step=5.0, win=10.0, k=8):
    """Map target to reference. Each probe (win s of target every step s) gets its k best matching
    reference positions; a Viterbi pass then picks one per probe so that consecutive probes advance
    ~step s through the reference (tolerating up to ±3% speed), paying a fixed price for a jump
    (a song boundary in a reordered upload). Periodic sounds that match in many places (heartbeats,
    clocks, repeated choruses) are resolved by their neighbours instead of by the argmax alone.
    Returns list of (target_t, ref_t, score) on the chosen path."""
    W, S = int(win * FPS), int(step * FPS)
    N = 1 << int(np.ceil(np.log2(len(rf) + W)))
    RF = np.fft.rfft(rf, n=N, axis=0)
    cand = []  # per probe: [(ref_t, score)]
    for i in range(0, len(tf) - W, S):
        PF = np.fft.rfft(tf[i:i + W], n=N, axis=0)
        c = np.fft.irfft((RF * np.conj(PF)).sum(1), n=N)[: len(rf) - W + 1] / W
        picks = []
        for j in np.argsort(c)[::-1]:  # k best, at least 2 s apart
            if all(abs(j - p) >= 2 * FPS for p in picks): picks.append(int(j))
            if len(picks) == k: break
        cand.append([(i / FPS, j / FPS, float(c[j])) for j in picks])
    if not cand: return []
    JUMP = 0.35  # score given up for leaving the path
    best = [np.array([s for _, _, s in cand[0]])]
    back = []
    for p in range(1, len(cand)):
        prev, cur = cand[p - 1], cand[p]
        tot = np.empty(len(cur)); arg = np.empty(len(cur), int)
        for a, (_, r, s) in enumerate(cur):
            trans = []
            for b, (_, r0, _) in enumerate(prev):
                dev = abs((r - r0) - step)
                cost = 0.0 if dev <= 0.03 * step + 0.1 else min(JUMP, 0.05 + dev * 0.05)
                trans.append(best[-1][b] - cost)
            b = int(np.argmax(trans)); tot[a] = trans[b] + s; arg[a] = b
        best.append(tot); back.append(arg)
    idx = int(np.argmax(best[-1])); path = [idx]
    for arg in reversed(back):
        idx = int(arg[idx]); path.append(idx)
    path.reverse()
    return [cand[p][a] for p, a in enumerate(path)]

def runs(path, step=5.0):
    """Split the aligned path into runs that advance steadily through the reference. Each run gets a
    least-squares fit target_t = a + b * ref_t (b > 1: upload runs slow; b < 1: fast)."""
    out, cur = [], [path[0]] if path else []
    for p0, p1 in zip(path, path[1:]):
        if abs((p1[1] - p0[1]) - step) <= 0.03 * step + 0.2: cur.append(p1)
        else:
            out.append(cur); cur = [p1]
    if cur: out.append(cur)
    res = []
    for r in out:
        t = np.array([p[0] for p in r]); rt = np.array([p[1] for p in r]); sc = np.array([p[2] for p in r])
        if len(r) >= 2: b, a = np.polyfit(rt, t, 1)
        else: b, a = 1.0, t[0] - rt[0]
        # r_last: where the last probe *starts*; r1 adds its 10 s window, which may already be past
        # the song this run belongs to
        res.append({"t0": t[0], "t1": t[-1] + 10, "r0": rt[0], "r1": rt[-1] + 10, "r_last": rt[-1], "a": a, "b": b,
                    "n": len(r), "score": float(np.median(sc))})
    return res

def onsets(x):
    """Music onsets after silent gaps in 8 kHz mono audio (seconds)."""
    e = lambda hop: 20 * np.log10(np.sqrt(np.mean(x[: len(x) // hop * hop].reshape(-1, hop).astype(np.float64) ** 2, axis=1)) + 1e-9)
    e50, e10 = e(ASR // 20), e(ASR // 100)
    low = e50 < np.percentile(e50, 90) - 20
    gaps, i = [], 0
    while i < len(low):
        if low[i]:
            j = i
            while j < len(low) and low[j]: j += 1
            if j - i >= 8:
                if gaps and i / 20 - gaps[-1][1] < 2.0: gaps[-1][1] = j / 20
                else: gaps.append([i / 20, j / 20])
            i = j
        else: i += 1
    out = []
    for g0, g1 in gaps:
        a, b = int(g0 * 100), min(int((g1 + 1.5) * 100), len(e10) - 51)
        if b <= a: continue
        floor = np.median(e10[a: max(a + 1, int(g1 * 100))])
        for k in range(b, a, -1):  # last upward crossing of floor+12 dB that stays > floor+6 for 0.5 s
            if e10[k - 1] < floor + 12 <= e10[k] and np.all(e10[k:k + 50] > floor + 6):
                out.append(k / 100); break
    return np.array(out)

# ---------- titles ----------

TAG = re.compile(r"\s*[\(\[\{][^\)\]\}]*(official|vinyl|rip|remaster|visuali[sz]er|audio|video|lyric|\bhq\b|\bhd\b|4k|bonus"
                 r"|explicit|concert|tour|live|film|edit|version|mix|screen|mono|stereo|\d{4})[^\)\]\}]*[\)\]\}]", re.I)

def clean_titles(titles):
    """Drop '(Official Visualizer)', '[Vinyl RIP]', '(Concert Screen Film)' tags, 'A1.'/'01.' prefixes,
    trailing HQ/HD, and an 'Artist – ' prefix or ' - Artist' suffix shared by most titles."""
    t = [TAG.sub("", x) for x in titles]
    t = [re.sub(r"^\s*(?:[A-Da-d]\d{1,2}|\d{1,2})[.):]?\s+(?=\S)", "", x) for x in t]
    t = [re.sub(r"\s*[℗©]\s*\d{4}\b", "", x) for x in t]
    t = [re.sub(r"[\s|/-]*(?:\bHQ\b|\bHD\b|/)+[\s|/-]*$", "", x, flags=re.I).strip() for x in t]
    for pat, sub in ((r"^(.{2,60}?)\s+[-–—|]\s+", "^{}\\s+[-–—|]\\s+"), (r"\s+[-–—|]\s+([^-–—|]{2,60})$", "\\s+[-–—|]\\s+{}$")):
        found = [m.group(1) for m in (re.search(pat, x) for x in t) if m]
        if found:
            top = max(set(found), key=found.count)
            if found.count(top) >= max(2, len(t) / 2):
                t = [re.sub(sub.format(re.escape(top)), "", x).strip() for x in t]
    return [x.strip(" -–—|") or y for x, y in zip(t, titles)]
