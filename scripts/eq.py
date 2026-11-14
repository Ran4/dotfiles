#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# ///
"""
A tiny TUI to switch the HD 58X EQ between warm, flat, open and off.

    warm flat open
         off

←/→ to move between the presets (wrapping around), ↓ to off, ↑ back to the last
preset, 1-4 (or w/f/o) to jump straight to one, q or Esc to quit.
The switching itself is done by ~/.local/bin/hd58x.
"""
import curses
import os
import subprocess

MODES = {
    "warm": "bass shelves, -6 dB preamp",
    "flat": "-6 dB preamp only (level-matched A/B against warm/open)",
    "open": "less boxy: +6 dB sub shelf, -2.2 dB at 220 Hz, +5 dB at 10 kHz, -6 dB preamp",
    "off": "straight to the DX5 II, no EQ (6 dB louder than flat)",
}
NAMES = list(MODES)
PRESETS = ["warm", "flat", "open"]  # the top row; "off" sits below it
KEYS = {ord("w"): "warm", ord("f"): "flat", ord("o"): "off"}
KEYS |= {ord(str(i)): name for i, name in enumerate(NAMES, 1)}


def hd58x(arg: str) -> tuple[bool, str]:
    try:
        r = subprocess.run(["hd58x", arg], capture_output=True, text=True)
    except FileNotFoundError:
        return False, "hd58x not found in PATH"
    return r.returncode == 0, (r.stdout.strip() or r.stderr.strip())


def put(win, y: int, x: int, text: str, attr: int = 0) -> None:
    # A too-small terminal just cuts the text off instead of crashing.
    try:
        win.addstr(y, x, text, attr)
    except curses.error:
        pass


def tab(win, y: int, x: int, name: str, mode: str | None) -> None:
    put(win, y, x, f" {name} ", curses.A_REVERSE | curses.A_BOLD if name == mode else curses.A_DIM)


def draw(win, mode: str, error: str) -> None:
    win.erase()
    put(win, 1, 2, "HD 58X EQ", curses.A_BOLD)
    x = 2
    for name in PRESETS:
        tab(win, 3, x, name, mode)
        if name == "flat":
            tab(win, 4, x, "off", mode)
        x += len(name) + 4
    put(win, 6, 2, MODES.get(mode) or f"default output is something else: {mode}")
    if error:
        put(win, 7, 2, error, curses.A_BOLD)
    put(win, 9, 2, "←/→ preset · ↓ off · ↑ back · 1-4 · q quit", curses.A_DIM)
    win.refresh()


def main(win) -> None:
    curses.curs_set(0)
    curses.use_default_colors()
    # Re-read the state every second, so a switch made elsewhere shows up here too.
    win.timeout(1000)
    error = ""
    last = "open"  # where ↑ goes from off until a preset has been seen
    while True:
        # warm/flat/open/off, or the default sink's name if it is none of them.
        _, mode = hd58x("mode")
        if mode in PRESETS:
            last = mode
        draw(win, mode, error)

        key = win.getch()
        if key in (ord("q"), 27):
            return
        target = KEYS.get(key)
        if key == curses.KEY_DOWN:
            target = "off"
        elif key == curses.KEY_UP:
            target = last
        elif key in (curses.KEY_LEFT, curses.KEY_RIGHT) and mode in PRESETS:
            i = PRESETS.index(mode) + (-1 if key == curses.KEY_LEFT else 1)
            target = PRESETS[i % len(PRESETS)]
        if target and target != mode:
            ok, out = hd58x(target)
            error = "" if ok else out


if __name__ == "__main__":
    # Make Esc quit right away instead of after curses' default 1 s wait.
    os.environ.setdefault("ESCDELAY", "25")
    curses.wrapper(main)
