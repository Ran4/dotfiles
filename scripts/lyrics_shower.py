#!/usr/bin/env python
"""
A python helper script that will automatically search for and print the
currently played song whenever the song changes (and once first on startup).

Requires two extra scripts to work.
"""
import time
from subprocess import Popen, PIPE

#A script that outputs currently playing song with format $ARTIST - $SONG
NOW_PLAYING_COMMAND = "/home/ran/dotfiles/scripts/nowplaying.sh"

#A script that outputs the currently playing lyrics to stdout
#~ PRINT_LYRICS_COMMAND = "/Users/ran/dotfiles/scripts/mly_nowplaying.sh"
PRINT_LYRICS_COMMAND = "/home/ran/dotfiles/scripts/mly_nowplaying.sh"

DELAY_BETWEEN_UPDATES_IN_SECONDS = 0.5

def auto_print_latest_lyrics():
    now_playing = get_nowplaying()
    prev_playing = None
    while True:
        if now_playing != prev_playing:
            if prev_playing is not None:
                clear_screen()
                time.sleep(0.1)
            ret = print_lyrics()
            print "Looking for {}".format(now_playing)
            prev_playing = now_playing
            
        time.sleep(DELAY_BETWEEN_UPDATES_IN_SECONDS)
        now_playing = get_nowplaying()

def get_nowplaying():
    p = Popen(NOW_PLAYING_COMMAND.split(" "),
        stdout=PIPE, stderr=PIPE, stdin=PIPE)
    return p.stdout.read().strip()

def clear_screen():
    Popen("clear")

def print_lyrics():
    Popen(PRINT_LYRICS_COMMAND, stdout=PIPE, stdin=PIPE)

if __name__ == "__main__":
    auto_print_latest_lyrics()
