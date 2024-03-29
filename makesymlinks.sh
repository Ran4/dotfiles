#!/usr/bin/env bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# Found at
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

#ORANGE='\033[0;33m'
LBLUE='\033[1;34m'
NC='\033[0m'

########## Variables
dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="agignore bashrc bash_aliases bash_setprompt curlrc inputrc dircolors gitconfig gitignore_global vimrc ideavimrc vim xcape_config lesskey tmux.conf hhighlighter.sh custom/kth_tmux.conf custom/ranl412_tmux.conf zshrc zsh pylintrc django.pylintrc pep8 config/youtube-dl config/alacritty/alacritty.yml moc/config moc/keymap.conf mpdconf mpdasrc pdbrc imwheelrc"

##########

# create dotfiles_old in homedir
echo -e "${LBLUE}Creating $olddir for backup of any existing dotfiles in ~${NC}"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo -e "${LBLUE}Changing to the $dir directory${NC}"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles from ~ to $olddir and creating symlinks to files in home directory..."
for file in $files; do
    mv ~/.$file $olddir
    echo -en "$file "
    ln -s $dir/$file ~/.$file
    echo -e "ln -s $dir/$file ~/.$file"
done
echo -e "\n...done"

echo -e "${LBLUE}Creating ~/.custom and ~/.identifiers folders and copying files to ~/.custom${NC}"
mkdir -p ~/.identifiers
mkdir -p ~/.custom
cp -r custom/* ~/.custom
echo "...done"

echo -e "${LBLUE}Reloading bash${NC}"
source ~/.bashrc
echo "...done"

if [ -f ~/.identifiers/hidpi ]; then
    echo -e "${LBLUE}Creating hi-dpi Xresources symlink${NC}"
    ln -sf $dir/Xresources_hidpi ~/.Xresources
else
    if [ -f ~/.identifiers/40inch ]; then
        echo -e "${LBLUE}Creating Xresources_40inch symlink${NC}"
        ln -sf $dir/Xresources_40inch ~/.Xresources
    else
        echo -e "${LBLUE}Creating Xresources symlink${NC}"
        ln -sf $dir/Xresources ~/.Xresources
    fi
fi
echo "...done"

if command_exists xrdb ; then
    echo -e "${LBLUE}Loading X resources (xrdb -load ~/.Xresources)${NC}"
    xrdb -load ~/.Xresources
    echo "...done"
fi

echo -e "${LBLUE}Sourcing tmux (tmux source-file ~/.tmux.conf)${NC}"
tmux source-file ~/.tmux.conf
echo "...done"

echo -e "${LBLUE}Building lesskey (lesskey -o ~/.less ~/.lesskey)${NC}"
lesskey -o ~/.less ~/.lesskey
echo "...done"

echo -e "${LBLUE}Creating symlink to ~/.ssh/config (ln -s $dir/ssh_config ~/.ssh/config)${NC}"
ln -sf $dir/ssh_config ~/.ssh/config
echo "...done"

if [ -d ~/.ghc ]; then
    echo -e "${LBLUE}Creating symlink to ~/.ghc/ghci.conf${NC}"
    ln -sf $dir/ghc/ghci.conf ~/.ghc/ghci.conf
    echo "...done"
fi

echo -e "${LBLUE}Creating nowplaying.sh symlink to /usr/bin (ln -s $dir/scripts/ /usr/bin/nowplaying)${NC}"
sudo ln -sf $dir/scripts/nowplaying.sh  /usr/bin/nowplaying
echo "...done"

echo -e "${LBLUE}Creating reload_chrome symlink to /usr/bin${NC}"
sudo ln -sf $dir/scripts/reload_chrome /usr/bin/reload_chrome
echo "...done"

echo -e "${LBLUE}Creating symlink to ~/.tmuxp${NC}"
ln -sfn $dir/tmuxp ~/.tmuxp
echo "...done"

if command_exists nvim ; then
    echo -e "${LBLUE}Symlinking vim folder and vimrc for nvim to use${NC}"
    ln -sfn ~/dotfiles/vim ~/.config/nvim
    ln -sfn ~/dotfiles/vimrc ~/.config/nvim/init.vim
    echo "...done"
fi

# echo -e "${LBLUE}Copying sunrise-modified-ran.zsh-theme file to ~/.oh-my-zsh/themes/${NC}"
# cp $dir/oh-my-zsh/themes/sunrise-modified-ran.zsh-theme ~/.oh-my-zsh/themes/

echo -e "${LBLUE}Creating symlink ~/.zprezto/modules/prompt/functions/prompt_rangiddie_setup ${NC}"
ln -sfn $dir/prompt_rangiddie_setup ~/.zprezto/modules/prompt/functions/prompt_rangiddie_setup
echo "...done"

if command_exists i3 ; then
    echo -e "${LBLUE}Creating symlink to i3 config (ln -s $dir/i3/config ~/.i3/config)${NC}"
    ln -sfn $dir/i3 ~/.config/i3
fi
