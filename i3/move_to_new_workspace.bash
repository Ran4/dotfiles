#!/usr/bin/env bash
# from https://faq.i3wm.org/question/6200/obtain-info-on-current-workspace-etc.1.html
CURRENT_WORKSPACE_NAME=$(i3-msg -t get_workspaces | \
    jq ".[] | select(.focused==true).name" | \
    cut -d"\"" -f2)
NEW_WORKSPACE=$(python3 ~/.i3/get_new_workspace.py $CURRENT_WORKSPACE_NAME)
echo $NEW_WORKSPACE > /tmp/lol.txt
i3-msg -t command move container to workspace $NEW_WORKSPACE
