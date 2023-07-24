#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=s0

function has-session {
    tmux has-session -t $1 2>/dev/null
}

has-session "s0"
if [ "$?" -eq 1 ] ; then
    tmux new-session -s "$sn" -d
    tmux -2 attach-session -t "$sn"
else
    tmux -2 attach-session -t "$sn"
fi


# OLD: Starts api-layke in tab 1, and runs postgres+rabbitmq for layke in tab 2
# has-session "s0"
# if [ "$?" -eq 1 ] ; then
#     cd ~/other/layke/api-layke/
#     tmux -2 attach || tmux new-session -s "$sn" -n "postgres+rmq" -d
#     tmux send-keys -t "$sn:1" "make postgres" Enter
#     tmux split-window -t "$sn:1"
#     tmux send-keys -t "$sn:1" "make rabbitmq" Enter
# 
#     cd ~/other/layke/api-layke/
#     tmux new-window -n api-layke
# 
#     # Select window #1 and attach to the session
#     tmux select-window -t "$sn:1"
#     tmux swap-window -t +1
#     tmux -2 attach-session -t "$sn"
# else
#     tmux -2 attach-session -t "$sn"
# fi
