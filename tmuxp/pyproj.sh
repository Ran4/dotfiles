#!/usr/bin/env bash
# Small shell script that will create a new project (with name given by the
# script's 1st argument) in ~/pyy, create a virtualenv, git init with python
# .gitignore and then load it as a new tmux session using tmuxp, using the
# configuration given in newpythonproj.yaml which activates the venv

OLD_DIR=$PWD

PROJNAME=$1
export PROJ_DIR=~/pyy/$PROJNAME

echo "cd ~/pyy"
cd ~/pyy

if [ -d $PROJNAME ]; then
    cd $PROJNAME
else
    echo "Creating new project '$PROJNAME'"
    
    echo "mkdir $PROJNAME"
    mkdir $PROJNAME
    echo "cd $PROJNAME"
    cd $PROJNAME
    
    echo "mkdir src"
    mkdir src

    virtualenv --python=python3.5 .venv
    touch requirements.txt
    echo "__pycache__\n*.pyc\n.venv" >> .gitignore
    git init
    git add .gitignore requirements.txt
fi 

tmuxp load newpythonproj
echo "cd to old dir where old dir is $OLD_DIR"
cd $OLD_DIR
