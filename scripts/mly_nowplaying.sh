#!/usr/bin/env bash
command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists rhythmbox-client ; then
    ARTIST="$(rhythmbox-client --no-start --print-playing-format %ta)"
    SONG="$(rhythmbox-client --no-start --print-playing-format %tt)"
else # Assume OS X, use osascript to get from iTunes instead
    ARTIST=$(osascript -e 'tell application "iTunes" to if player state is playing then artist of current track')
    SONG=$(osascript -e 'tell application "iTunes" to if player state is playing then name of current track')
fi

python ~/git/other/metallum/metallum.py "$ARTIST" "$SONG"
