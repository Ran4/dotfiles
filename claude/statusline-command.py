#!/usr/bin/env python3
"""Claude Code statusline — pretty segments using only standard Unicode (no Nerd Font required)."""

import json
import os
import re
import subprocess
import sys

RESET = "\033[0m"
BOLD = "\033[1m"
DIM = "\033[2m"


def c(code: int) -> str:
    return f"\033[38;5;{code}m"


CYAN = c(81)
GREEN = c(114)
LIME = c(149)
YELLOW = c(221)
ORANGE = c(209)
RED = c(203)
PINK = c(205)
PURPLE = c(141)
VIOLET = c(99)
BLUE = c(75)
GREY = c(244)
SILVER = c(250)
WHITE = c(255)

# BULLET = f" {DIM}{GREY}│{RESET} "
BULLET = f" "

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}


def get(path, default=None):
    cur = data
    for key in path.split("."):
        if isinstance(cur, dict) and key in cur:
            cur = cur[key]
        else:
            return default
    return cur if cur is not None else default


# 1. Working directory
cwd = get("cwd") or get("workspace.current_dir") or ""
dir_part = ""
if cwd:
    home = os.path.expanduser("~")
    short = cwd.replace(home, "~", 1) if cwd.startswith(home) else cwd
    base = os.path.basename(cwd) or short
    parent = os.path.dirname(short)
    if parent and parent != "." and parent != base:
        dir_part = f"{DIM}{GREY}{parent}/{RESET}{WHITE}{BOLD}{base}{RESET}"
    else:
        dir_part = f"{WHITE}{BOLD}{base}{RESET}"


# 2. Git branch + dirty
def git(args):
    try:
        out = subprocess.run(
            ["git", "-C", cwd, "--no-optional-locks"] + args,
            capture_output=True,
            text=True,
            timeout=2,
        )
        return out.stdout.strip() if out.returncode == 0 else ""
    except Exception:
        return ""


git_part = ""
if cwd and os.path.isdir(cwd):
    branch = git(["rev-parse", "--abbrev-ref", "HEAD"])

    if branch == "develop":
        git_part = ""

    elif branch:
        dirty_out = git(["status", "--porcelain"])
        if dirty_out:
            mark = f" {ORANGE}{BOLD}●{RESET}{DIM}{ORANGE}{RESET}"
        else:
            mark = f" {LIME}✓{RESET}"
        git_part = f"{PURPLE}{BOLD}⎇{RESET} {PURPLE}{branch}{RESET}{mark}"


# 3. Model
model_name = get("model.display_name") or get("model.id") or ""
model_part = ""
if model_name:
    short = model_name.replace("Claude ", "").replace(" (self-moderated)", "")
    model_part = f"{CYAN}{short}{RESET}"


def read_effort():
    direct = get("effort.level") or get("effort_level") or get("effort")
    if isinstance(direct, str) and direct:
        return direct
    if env := os.environ.get("CLAUDE_CODE_EFFORT_LEVEL"):
        return env
    model_id = re.sub(r"\[.*\]$", "", get("model.id") or "")
    candidates = []
    if cwd:
        candidates += [
            os.path.join(cwd, ".claude", "settings.local.json"),
            os.path.join(cwd, ".claude", "settings.json"),
        ]
    candidates.append(os.path.expanduser("~/.claude/settings.json"))
    for path in candidates:
        try:
            with open(path) as f:
                settings = json.load(f)
        except Exception:
            continue
        per_model = (settings.get("modelSettings") or {}).get(model_id) or {}
        if per_model.get("effortLevel"):
            return per_model["effortLevel"]
        if settings.get("effortLevel"):
            return settings["effortLevel"]
    return ""


EFFORT_COLORS = {
    "low": GREY,
    "medium": YELLOW,
    "high": ORANGE,
    "xhigh": PINK,
    "max": RED,
}
effort = read_effort() if model_name else ""
if effort:
    col = EFFORT_COLORS.get(effort.lower(), SILVER)
    # model_part += f" {DIM}{GREY}·{RESET} {col}{effort}{RESET}"
    model_part += f" {col}{effort}{RESET}"


# 4. Context window
def get_ctx_part():
    ctx_size = get("context_window.context_window_size") or (
        1_000_000 if get("exceeds_200k_tokens") else 200_000
    )
    used_pct = get("context_window.used_percentage")
    total_used = 0

    cur = get("context_window.current_usage") or {}
    if cur:
        total_used = (
            (cur.get("input_tokens") or 0)
            + (cur.get("cache_read_input_tokens") or 0)
            + (cur.get("cache_creation_input_tokens") or 0)
            + (cur.get("output_tokens") or 0)
        )

    if (used_pct is None or total_used == 0) and (transcript := get("transcript_path")):
        if os.path.isfile(transcript):
            try:
                with open(transcript, "rb") as f:
                    f.seek(0, 2)
                    size = f.tell()
                    f.seek(max(0, size - 262144))
                    tail = f.read().decode("utf-8", errors="ignore")
                usages = re.findall(r'"usage"\s*:\s*\{[^{}]*\}', tail)
                if usages:
                    last = usages[-1]

                    def num(key):
                        m = re.search(rf'"{key}"\s*:\s*(\d+)', last)
                        return int(m.group(1)) if m else 0

                    total_used = (
                        num("input_tokens")
                        + num("cache_read_input_tokens")
                        + num("cache_creation_input_tokens")
                        + num("output_tokens")
                    )
            except Exception:
                pass

    if used_pct is None and total_used > 0 and ctx_size > 0:
        used_pct = (total_used / ctx_size) * 100

    ctx_part = ""
    if used_pct is not None and used_pct >= 0:
        used_int = int(round(used_pct))
        used_int = max(0, min(used_int, 100))
        remaining_int = 100 - used_int

        if remaining_int >= 60:
            ctx_color, head = LIME, "▲"
        elif remaining_int >= 35:
            ctx_color, head = YELLOW, "▲"
        elif remaining_int >= 15:
            ctx_color, head = ORANGE, "▼"
        else:
            ctx_color, head = RED, "▼"

        bar_w = 10
        filled = used_int * bar_w // 100
        filled = max(0, min(filled, bar_w))
        bar = ("█" * filled) + (
            f"{DIM}{GREY}" + "─" * (bar_w - filled) + RESET + ctx_color
        )

        if total_used > 0:
            if total_used >= 1000:
                tok_str = f"{total_used / 1000:.1f}k"
            else:
                tok_str = str(total_used)
            tok_disp = f" {DIM}{GREY}({tok_str}){RESET}"
        else:
            tok_disp = ""

        ctx_part = (
            f"{ctx_color}{BOLD}{head}{RESET} "
            f"{ctx_color}{bar}{RESET} "
            f"{ctx_color}{BOLD}{used_int}%{RESET}{tok_disp}"
        )
    else:
        ctx_part = f"used_pct: {used_pct}, "
        # ctx_part = f"{DIM}{GREY}△ ctx pending{RESET}"

    return ctx_part


# 5. Rate limits
import time
from datetime import datetime


def fmt_reset(epoch):
    if not epoch:
        return ""
    try:
        delta = int(epoch) - int(time.time())
    except (TypeError, ValueError):
        return ""
    if delta <= 0:
        return "now"
    d, rem = divmod(delta, 86400)
    h, rem = divmod(rem, 3600)
    m, _ = divmod(rem, 60)
    if d > 0:
        return f"{d}d{h}h"
    if h > 0:
        return f"{h}h{m:02d}m"
    return f"{m}m"


def pct_piece(label, pct, calm=LIME):
    """`calm` is the colour while there is plenty left (under 40%)."""
    if pct is None:
        return ""
    pct_int = max(0, min(int(round(pct)), 100))

    # I don't care if it's sub 5%
    if pct_int < 5:
        return ""

    if pct_int >= 90:
        col = RED
    elif pct_int >= 70:
        col = ORANGE
    elif pct_int >= 40:
        col = YELLOW
    else:
        col = calm
    return f"{DIM}{GREY}{label}{RESET}{col}{BOLD}{pct_int}%{RESET}"


def rate_segment(label, pct, resets_at, extra=()):
    pieces = [p for p in [pct_piece(label, pct), *extra] if p]
    if not pieces:
        return ""
    if reset := fmt_reset(resets_at):
        pieces.append(f"{DIM}{GREY}{reset}{RESET}")
    return " ".join(pieces)


# Claude Code itself stops trusting its cached /usage answer after an hour.
USAGE_CACHE_STALE_AFTER = 3600


def model_weekly_limits():
    """Per-model weekly limits (e.g. Fable) as ([pct pieces], reset epoch).

    Claude Code only hands five_hour/seven_day to the statusline, so these come
    from the copy of the /usage answer it keeps in ~/.claude.json. It rewrites
    that copy only now and then (running /usage does it), so the number can lag
    behind; past USAGE_CACHE_STALE_AFTER it gets a trailing "?".
    """
    try:
        with open(os.path.expanduser("~/.claude.json")) as f:
            cfg = json.load(f)
        cache = cfg["cachedUsageUtilization"]
        if cache.get("accountUuid") != (cfg.get("oauthAccount") or {}).get(
            "accountUuid"
        ):
            return [], None
        rows = cache["utilization"]["limits"] or []
        stale = time.time() - cache["fetchedAtMs"] / 1000 > USAGE_CACHE_STALE_AFTER
    except Exception:
        return [], None

    pieces, reset_epoch = [], None
    for row in rows:
        if not isinstance(row, dict) or row.get("kind") != "weekly_scoped":
            continue
        name = ((row.get("scope") or {}).get("model") or {}).get("display_name")
        if not name:
            continue
        try:
            row_reset = datetime.fromisoformat(row.get("resets_at")).timestamp()
        except (TypeError, ValueError):
            row_reset = None
        # Past its reset, the cached number belongs to last week.
        if row_reset is not None and row_reset <= time.time():
            continue
        # Purple rather than 7d's green, so the two numbers can be told apart.
        if piece := pct_piece(f"{name.lower()}=", row.get("percent"), calm=PURPLE):
            pieces.append(piece + (f"{DIM}{GREY}?{RESET}" if stale else ""))
            reset_epoch = reset_epoch or row_reset
    return pieces, reset_epoch


five_h_pct = get("rate_limits.five_hour.used_percentage")
five_h_reset = get("rate_limits.five_hour.resets_at")
seven_d_pct = get("rate_limits.seven_day.used_percentage")
seven_d_reset = get("rate_limits.seven_day.resets_at")

model_pieces, model_reset = model_weekly_limits()

five_h_part = rate_segment("5h=", five_h_pct, five_h_reset)
seven_d_part = rate_segment(
    "7d=", seven_d_pct, seven_d_reset or model_reset, model_pieces
)

# Model-specific weekly limits (e.g. seven_day_fable / seven_day_opus)
extra_rate_parts = []
# rl = get("rate_limits")
# if isinstance(rl, dict):
#     for rl_key, rl_val in rl.items():
#         if rl_key in ("five_hour", "seven_day") or not isinstance(rl_val, dict):
#             continue
#         label = rl_key.replace("seven_day_", "7d ").replace("_", " ")
#         seg = rate_segment(
#             label, rl_val.get("used_percentage"), rl_val.get("resets_at")
#         )
#         if seg:
#             extra_rate_parts.append(seg)


# 6. Output style
style = get("output_style.name") or ""
style_part = ""
if style and style.lower() not in ("default", "normal"):
    style_part = f"{DIM}{GREY}◆ {style}{RESET}"


parts = [
    p
    for p in [
        dir_part,
        git_part,
        model_part,
        # get_ctx_part(),
        five_h_part,
        seven_d_part,
        *extra_rate_parts,
        style_part,
    ]
    if p
]
print(BULLET.join(parts))
