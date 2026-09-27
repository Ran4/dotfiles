# /// script
# requires-python = ">=3.11"
# ///
"""Search YouTube for every upload of one album: full-album videos (vinyl rips, needle drops, CD rips,
"HQ" uploads), albums uploaded per side (Side 1 + Side 2), fan playlists, and the official release
(from the artist channel's Releases tab, where YouTube keeps official albums as OLAK5uy... playlists).

    uv run find.py "Motörhead - Ace of Spades" [--live] [--min-minutes 12] [--out cands.json]

Prints a table and writes JSON. Filters only the obvious junk (reactions, unboxings, covers, other
albums, < min-minutes); choosing what to measure is left to the caller.
"""
import argparse, concurrent.futures as cf, json, re, statistics, subprocess, unicodedata, urllib.parse

VIDEO_QUERIES = ["{q} full album", "{q} full album vinyl rip", "{q} vinyl rip", "{q} LP full album",
                 "{q} needle drop", "{q} full album original", "{q} full album HQ", "{q} full album remastered",
                 "{q} full album 1st press", "{q} side 1", "{q}"]
JUNK = re.compile(r"unbox|reaction|react\b|review|\bcover\b|karaoke|lesson|tutorial|how to play|interview"
                  r"|documentary|trailer|teaser|\bcam\b|tier list|ranking|podcast|guitar pro|backing track|first time"
                  r"|hearing|analysis|explained|condensed|\bremix|8.?bit|slowed|reverb|nightcore|sped up|reversed"
                  r"|432\s*hz|acapella|a cappella|tribute|lyrics|the story of|classic albums|music video", re.I)
LIVE = re.compile(r"\blive\b|concert|\btour\b|bootleg", re.I)
SIDE = re.compile(r"\b(?:side|part)\s*[-:#]?\s*(a|b|c|d|1|2|3|4|one|two|three|four)\b", re.I)
SIDE_ORDER = {"a": 1, "1": 1, "one": 1, "b": 2, "2": 2, "two": 2, "c": 3, "3": 3, "three": 3, "d": 4, "4": 4, "four": 4}

def norm(s):
    # "M̲otö̲rhea̲d", "𝐀𝐜𝐞" -> "motorhead", "ace": NFKD folds styled letters, then drop combining marks
    s = "".join(c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c))
    return re.sub(r"[^a-z0-9]+", " ", s.lower()).split()

def relevant(title, need, min_frac):
    have = set(norm(title))
    return bool(need) and sum(t in have for t in need) / len(need) >= min_frac

def ytdlp_flat(url, n=None):
    cmd = ["yt-dlp", "--no-warnings", "--flat-playlist", "--dump-json"]
    if n: cmd += ["--playlist-end", str(n)]
    try:
        out = subprocess.run(cmd + [url], capture_output=True, text=True, timeout=180).stdout
    except subprocess.TimeoutExpired:
        return []
    return [json.loads(l) for l in out.splitlines() if l.startswith("{")]

def mmss(s):
    return f"{int(s)//3600}:{int(s)%3600//60:02d}:{int(s)%60:02d}" if s >= 3600 else f"{int(s)//60}:{int(s)%60:02d}"

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("query")
    ap.add_argument("--live", action="store_true", help="keep live recordings")
    ap.add_argument("--min-minutes", type=float, default=12)
    ap.add_argument("--per-query", type=int, default=15)
    ap.add_argument("--out", default="candidates.json")
    a = ap.parse_args()

    q = a.query
    # "Artist - Album": every album word must be in the title (artists get spelled oddly);
    # otherwise most query words must be
    artist = None
    if " - " in q:
        artist, album = q.split(" - ", 1)
        need, min_frac = [t for t in norm(album) if len(t) > 1 or t.isdigit()], 1.0
        q = f"{artist} {album}"
    else:
        need, min_frac = norm(q), 0.75
    urls = [f"ytsearch{a.per_query}:{t.format(q=q)}" for t in VIDEO_QUERIES]
    pl_url = ("https://www.youtube.com/results?search_query=" + urllib.parse.quote_plus(q + " album")
              + "&sp=EgIQAw%253D%253D")  # search filter: playlists only
    with cf.ThreadPoolExecutor(len(urls) + 1) as ex:
        vid_futs = [ex.submit(ytdlp_flat, u) for u in urls]
        pl_fut = ex.submit(ytdlp_flat, pl_url, 15)
        results = [f.result() for f in vid_futs]
        playlists = pl_fut.result()

    def is_artist_channel(e):
        """Verified channel named like the artist (or 'Artist - Topic'): the official uploader."""
        ch = e.get("channel") or e.get("uploader") or ""
        if re.search(r"- topic$|vevo$", ch, re.I): return True
        if not e.get("channel_is_verified"): return False
        want = norm(artist) if artist else None
        return (norm(re.sub(r"\bofficial\b", "", ch, flags=re.I)) == want) if want else True

    videos, sides, seen, artist_channels = [], [], set(), {}
    for entries in results:
        for e in entries:
            vid, title = e.get("id"), e.get("title") or ""
            dur = e.get("duration") or 0
            if e.get("channel_url") and is_artist_channel(e): artist_channels[e["channel_url"]] = e.get("channel")
            if not vid or vid in seen: continue
            seen.add(vid)
            if JUNK.search(title) or not relevant(title, need, min_frac): continue
            if LIVE.search(title) and not (a.live or "live" in need): continue  # "Live Through This" is a studio album
            v = {"kind": "video", "id": vid, "title": title, "channel": e.get("channel") or e.get("uploader"),
                 "official": is_artist_channel(e), "duration": dur, "views": e.get("view_count") or 0,
                 "url": f"https://www.youtube.com/watch?v={vid}"}
            m = SIDE.search(title)
            if m and dur >= 5 * 60:
                v["side"] = SIDE_ORDER[m.group(1).lower()]; sides.append(v)
            elif dur >= a.min_minutes * 60:
                videos.append(v)

    # official albums: the artist channel's Releases tab (album search never returns them)
    pls = []
    for ch_url, ch in list(artist_channels.items())[:2]:
        for p in ytdlp_flat(ch_url.rstrip("/") + "/releases", 200):
            if relevant(p.get("title") or "", need, 1.0):
                pls.append({"kind": "playlist", "id": p["id"], "title": p.get("title"), "channel": ch,
                            "official": True, "source": "releases", "url": f"https://www.youtube.com/playlist?list={p['id']}"})
    for p in playlists:
        pid, title, ch = p.get("id"), p.get("title") or "", p.get("channel") or p.get("uploader") or ""
        if not pid or any(x["id"] == pid for x in pls) or JUNK.search(title): continue
        if LIVE.search(title) and not (a.live or "live" in need): continue
        if not relevant(title + " " + ch, need, min_frac): continue
        official = pid.startswith("OLAK5uy") or bool(re.search(r"official|- topic|vevo", ch, re.I))
        pls.append({"kind": "playlist", "id": pid, "title": title, "channel": ch, "official": official,
                    "url": f"https://www.youtube.com/playlist?list={pid}"})

    # albums uploaded per side: pair up a channel's side videos -> measure.py target 'ID1+ID2'
    pairs, by_ch = [], {}
    for v in sides: by_ch.setdefault(v["channel"], []).append(v)
    for ch, vs in by_ch.items():
        vs.sort(key=lambda v: v["side"])
        picked, used = [], set()
        for v in vs:
            if v["side"] not in used: picked.append(v); used.add(v["side"])
        if len(picked) >= 2 and picked[0]["side"] == 1:
            pairs.append({"kind": "sides", "id": "+".join(v["id"] for v in picked), "channel": ch,
                          "duration": sum(v["duration"] for v in picked), "views": max(v["views"] for v in picked),
                          "title": " + ".join(v["title"] for v in picked), "official": all(v["official"] for v in picked)})
    videos += pairs

    # Length clusters: sorted lengths, a new cluster wherever the next upload is > 2% longer.
    # Each cluster is usually one edition (original LP / bonus-track reissue / deluxe). A..Z by size.
    clusters = []
    for v in sorted(videos, key=lambda v: v["duration"]):
        if clusters and v["duration"] <= clusters[-1][-1]["duration"] * 1.02: clusters[-1].append(v)
        else: clusters.append([v])
    clusters.sort(key=lambda c: -len(c))
    summary = []
    for i, c in enumerate(clusters):
        label = chr(ord("A") + i) if i < 26 else "?"
        for v in c: v["cluster"] = label
        summary.append({"cluster": label, "n": len(c), "median_seconds": statistics.median(v["duration"] for v in c),
                        "min_seconds": c[0]["duration"], "max_seconds": c[-1]["duration"]})
    videos.sort(key=lambda v: (v["cluster"], -v["views"]))

    json.dump({"query": a.query, "length_clusters": summary, "videos": videos, "playlists": pls},
              open(a.out, "w"), ensure_ascii=False, indent=1)

    print(f"{len(videos)} uploads ({len(pairs)} side pairs), {len(pls)} playlists -> {a.out}")
    print("length clusters: " + ", ".join(f"{c['cluster']} {mmss(c['min_seconds'])}–{mmss(c['max_seconds'])} ({c['n']})" for c in summary) + "\n")
    print(f"{'id':25s} {'cl':2s} {'len':>7s} {'views':>9s}  title — channel")
    for v in videos:
        tag = ("[OFFICIAL] " if v["official"] else "") + ("[sides] " if v["kind"] == "sides" else "")
        print(f"{v['id']:25s} {v['cluster']:2s} {mmss(v['duration']):>7s} {v['views']:>9d}  {tag}{v['title']} — {v['channel']}")
    print("\nplaylists:")
    for p in pls:
        print(f"{'OFFICIAL ' if p['official'] else '         '}{p['id']}  {p['title']} — {p['channel']}"
              + ("  (artist Releases tab)" if p.get("source") == "releases" else ""))

if __name__ == "__main__":
    main()
