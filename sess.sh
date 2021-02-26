#!/bin/bash
# var for session name (to avoid repeated occurences)
if [ -z $1 ]; then
    echo "Usage: sess SESSION-NAME"
    echo "Example:"
    echo "    $ sess private"
    echo "    $ sess dotnet"
    echo
    echo "Current sessions:"
    tmux list-sessions
    exit
fi

session_name=$1

tmux has-session -t "$session_name" 2>/dev/null
if [ $? -eq 1 ] ; then
    cd ~
    tmux -2 attach -t "$session_name" || tmux new-session -s "$session_name" -d

    tmux set-option status-style bg=#109f10
    tmux -2 attach-session -t "$session_name"
else
    tmux -2 attach-session -t "$session_name"
fi
