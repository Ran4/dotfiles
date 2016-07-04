#!/bin/bash
SESSION_NAME=$1

function has-session {
    tmux has-session -t $1 2>/dev/null
}

if has-session "$SESSION_NAME" ; then
    tmux -2 attach-session -t $SESSION_NAME
else
    tmux new-session -s $SESSION_NAME -c "#{pane_current_path}"
    
    # case $SESSION_NAME in
    #     "elm")
    #         # FIRST_TAB_NAME=elm
    #         FIRST_TAB_DIRECTORY='~/elm'
    #         ;;
    #     *)
    #         FIRST_TAB_DIRECTORY='~'
    #         ;;
    # esac
    
    # Create a new session named $SESSION_NAME without attaching to it (-d ~ deattach)
    # tmux new-session -s $SESSION_NAME -d
    
    # tmux new-window -n $FIRST_TAB_NAME -c "$FIRST_TAB_DIRECTORY"
    # cd $FIRST_TAB_DIRECTORY
    # tmux new-window -c "#{pane_current_path}"
    # tmux new-window
    
    # Finally, attach to our newly created session
    # tmux -2 attach-session -t "$SESSION_NAME"
fi

# Things you might want to do:
# Select window #1 of session named $SESSION_NAME
# tmux select-window -t "$SESSION_NAME:1"
# tmux swap-window -t +1
