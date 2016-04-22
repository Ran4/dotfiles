#!/usr/bin/env bash

ARTIST=$(osascript -e 'tell application "iTunes" to if player state is playing then artist of current track')

SONG=$(osascript -e 'tell application "iTunes" to if player state is playing then name of current track')

echo $ARTIST - $SONG
