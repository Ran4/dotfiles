#!/bin/sh

#this is due to a itsalltext bug, see https://github.com/docwhat/itsalltext/issues/30
#export TMPDIR="/tmp/"

#Send files to vimserver (creating one called vimr automatically if needed).
SERVER_NAME=ITS_ALL_TEXT_SERVER
vim --serverlist | grep -q $SERVER_NAME

if [ $? -eq 0 ]; then #a server has been started
    if [ $# -eq 0 ]; then #no arguments given, start regular vim
        exec gvim -c "cd /tmp/.itsalltext/" +startinsert "$@"
    else #Trying to access server called $SERVER_NAME
        #exec gvim --servername $SERVER_NAME --remote-tab -c "cd /tmp/.itsalltext/" +startinsert "$@"
        exec gvim --servername $SERVER_NAME --remote-tab -c "cd /tmp/.itsalltext/" +startinsert "$@"
    fi
else #Start a new server called $SERVER_NAME
    #exec gvim --servername $SERVER_NAME -c "cd /tmp/.itsalltext/" +startinsert "$@"
    exec gvim --servername $SERVER_NAME -c "cd /tmp/.itsalltext/" +startinsert "$@"
fi

exec gvim -c "cd /tmp/.itsalltext/" +startinsert "$@"
#exec gvim -c "cd /tmp/.itsalltext/" +startinsert "$@"
