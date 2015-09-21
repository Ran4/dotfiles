#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=s0

function has-session {
    tmux has-session -t $1 2>/dev/null
}

has-session "s0"
if [ "$?" -eq 1 ] ; then
    # Start the session and window 0 in /etc
    #   This will also be the default cwd for new windows created
    #   via a binding unless overridden with default-path.
    cd ~
    tmux -2 attach || tmux new-session -s "$sn" -d

    cd ~/dotfiles
    tmux new-window -n dotfiles

    # Select window #1 and attach to the session
    tmux select-window -t "$sn:1"
    tmux swap-window -t +1
    tmux -2 attach-session -t "$sn"
else
    tmux -2 attach-session -t "$sn"
fi
