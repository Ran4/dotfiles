#!/bin/bash
#Help function to see if a command exists
command_exists () {
    type "$1" >/dev/null 2>/dev/null
}

LBLUE='\033[1;34m'
NC='\033[0m'

dir=~/dotfiles/mac                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="slate"

mkdir -p $olddir
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file $olddir
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

#ln -s /Users/ran/dotfiles/mac/slate /Users/ran/.slate

#For some reasons, DefaultKeyBinding.dict can't be symlinked
mkdir -p ~/Library/KeyBindings/
cp ~/dotfiles/mac/DefaultKeyBinding.dict ~/Library/KeyBindings/
