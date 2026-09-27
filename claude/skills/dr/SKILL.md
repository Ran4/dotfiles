---
name: dr
description: Find the least-compressed (highest dynamic range, "DR") version of an album on YouTube. Searches every full-album upload (vinyl rips, needle drops, CD rips, "HQ" uploads, Side 1 + Side 2 uploads, fan playlists) plus the official release, measures each one's real DR on identical song boundaries, verifies it is complete, in order, forward and at the right speed, and returns the best-sounding link with per-song timestamps. Use when the user types /dr <artist - album>, or asks for the "best version", "best quality", "best-sounding", "least compressed", "most dynamic", "original / not remastered", "pre-loudness-war" or "vinyl rip" version of an album, e.g. "give me best version available of ARTIST - ALBUM", "find the best-sounding upload of X on youtube", "which upload of X has the most dynamic range".
argument-hint: <artist - album>  (an artist alone works too)
---

# /dr: the best-sounding upload of an album on YouTube

Request: **$ARGUMENTS**

Every YouTube upload streams at the same ~128 kbps, so bitrate says nothing about which one
sounds best. **The mastering does**, and titles lie about it: "vinyl rip" uploads are often
CD rips, "HQ" means nothing, and some uploads are sped up, or even reversed to dodge Content
ID. So don't pick by title; download, measure and verify. Original pressings usually beat
modern remasters. *Ace of Spades*: 1980 vinyl rip DR 12.0 vs 10.2 for the official album
playlist and 8.9 for the most-viewed upload. *Dark Side of the Moon*: a vinyl-rip playlist at
11.7 vs 10.1 for the official 2023 remaster.

Scripts live in `~/.claude/skills/dr/scripts/`; run them with `uv run -q`. Work dir `W`:
`<session scratchpad>/dr-<album-slug>` if the system prompt lists a scratchpad, else `mktemp -d`.

## 1. Pin down the album

- Only an artist given: ask which album (AskUserQuestion, their 3-4 best-known studio albums).
- Look up the **original release** (Wikipedia): year, track list, total running time. It
  decides which length cluster is "the album" and which uploads are bonus-track reissues.

## 2. Search (~3 s)

```bash
uv run -q ~/.claude/skills/dr/scripts/find.py "ARTIST - ALBUM" --out $W/candidates.json
```

Use the "Artist - Album" form: every album word must then be in a title, and the artist's
verified channel is recognised as `[OFFICIAL]`. It prints:
- **length clusters** (one cluster ≈ one edition: original LP / bonus-track reissue / deluxe),
  shown as min–max length;
- videos, including `[sides]` pairs (an album uploaded as Side 1 + Side 2 from one channel,
  id `ID1+ID2`). The most careful first-press rips are often uploaded this way;
- playlists. Official albums come from the artist channel's Releases tab (`OLAK5uy…`).

Few hits: rerun with another spelling or the original-language title. `--live` keeps live albums.

## 3. Screen (~1 min for 8-12 uploads; use `run_in_background`)

Pick 8-12 from the cluster matching the original running time: titles claiming vinyl / LP /
first press / original year, the `[sides]` pairs, the most viewed, "HQ/FLAC" claims, the
`[OFFICIAL]` full-album video, and the official Releases-tab album. Skip other clusters
(different program, not comparable) unless the user wants that edition.

```bash
uv run -q ~/.claude/skills/dr/scripts/measure.py --dir $W ID ID1+ID2 PLAYLIST_ID ...
```

Results merge into `$W/results.json`; rerun with more ids any time. A download ERROR means the
upload is gone: never recommend a link you haven't measured.

| column | meaning |
|---|---|
| DR | Quick screen: DR per piece (playlist entries, or parts between silent gaps ≥ 60 s), duration-weighted. On gapless/segue albums pieces aren't songs, so **final ranking uses step 4**. |
| whole | DR of the whole program in one go (another rough view) |
| LUFS / LRA | Integrated loudness / loudness range. Louder usually means more squashed. |
| floor / source | Level inside the gaps between tracks. `digital silence` = digital source (or a noise-gated rip). `noise in gaps` = vinyl surface noise **or** tape hiss: analog-era digital remasters keep hiss too, so this is not proof of vinyl. Step 4's speed is. |
| `!! mixed masters?` | One piece far louder than the rest: different masters stitched together (official playlists do this, e.g. an "Official Video" among "Visualizers"). |
| `!! non-album entries?` / `entries under 60 s` | Playlist holds video edits, live takes, shorts. Don't recommend it; it is only used as a reference as a last resort. |

## 4. Rank on identical song boundaries (~10-15 s per upload)

```bash
uv run -q ~/.claude/skills/dr/scripts/chapters.py --dir $W --dr --ref REF_ID ID ID ...
```

Run it on **every** candidate of the right edition (the reference included) with **the same
`--ref`**: the official full-album video with chapters, or the clean official album playlist.
Without `--ref` it picks one (official first, flagged playlists last) and prints which. It
aligns each upload to the reference, maps every song start, and measures DR per song on those
boundaries (`DR on song boundaries` = `dr_aligned`, a plain mean over songs, like the DR
database). The measure.py table then shows `DRalign` and `speed` columns. **Rank by `DRalign`.**
Differences under ~0.5 are noise; within that band prefer: speed ≈ 0, correct order, no pause
between videos, views.

Reject or flag, whatever the DR:
- `only N% of the upload follows the reference` (coverage < 80%): reversed, altered, a different
  recording, or the wrong album. Never recommend it.
- `missing:` songs: incomplete upload (or a bonus-less reference: check the track list).
- `plays +2.6% vs reference: audibly off pitch` (|speed| ≥ 1.5%): mention it; the user may not
  want a sharp/flat album even if it measures well.
- `plays songs out of album order`: real on some rips (the Ace of Spades rip starts with side
  B's "The Chase…"). The table puts it right. Order + low coverage = altered upload.

**Speed is the source evidence**: ±0.00-0.05% vs a digital reference = a digital copy of that
master family; ≥ 0.1% = analog playback, a real vinyl/tape transfer (turntables are never
exact). If the reference is itself a vinyl rip, speeds are relative to that.

## 5. Timestamps for the winner

The `chapters.py` table for the winner is ready to paste: clickable song starts, album track
numbers, `how` (`gap` = exact onset after silence, `aligned` = from the alignment, ±2 s),
per-song DR. For playlists and side pairs, links go to the right video (`part k @ m:ss`).
- `upload's own timestamps: agree` → no table needed; say they're right.
- A start that sounds late/early: `chapters.py --dir $W ID --peek T0 T1` prints a 0.25 s
  loudness strip. A level clearly above the gap floor but under the song = a quiet intro
  (*Ace of Spades* "Jailbait" has ~6 s of it); the aligned start is right.

## 6. Answer

1. **The pick**: link, DR on song boundaries, source evidence (speed, floor), and how far
   ahead it is of the official and the most-viewed upload ("DR 12.0 vs 10.2 official").
2. **Ranking** of everything measured: DRalign, speed, source, link, short verdict. Name the
   liars (a "vinyl rip" at speed 0.00% with digital silence) and the rejects (reversed,
   off-pitch, incomplete).
3. **Timestamps** table, unless the winner's own timestamps agree.
4. Real caveats only. For example, a **playlist or side-pair winner on a gapless album**:
   YouTube pauses between videos and breaks the segues. Offer the best single-video upload as
   the gapless alternative. Mention that a lossless original pressing / early CD would beat
   any YouTube upload, but don't point to pirated downloads.

## 7. Clean up

`rm -rf $W` (hundreds of MB of audio), unless the user is still working on the same album.
