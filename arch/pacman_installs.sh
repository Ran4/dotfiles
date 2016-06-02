#!/usr/bin/env bash

#--needed to prevent pacman from trying to reinstall already existing applications
#alias install='sudo pacman -S --needed'
sudo pacman -S --needed gvim #gvim has +clipboard even for the CLI version)
sudo pacman -S --needed git
sudo pacman -S --needed zsh tmux ack-grep the_silver_searcher tree
sudo pacman -S --needed wget openssh xclip
sudo pacman -S --needed python python2 python-virtualenv
sudo pacman -S --needed pastebinit
sudo pacman -S --needed zathura zathura-pdf-poppler zathura-ps zathura-djvu
sudo pacman -S --needed eog
sudo pacman -S --needed feh
sudo pacman -S --needed i3-wm i3lock i3status

ZATHRCFILE=/etc/zathurarc
[ ! -f $ZATHRCFILE ] \
    && echo "writing $ZATHRCFILE" && echo "set scroll-step 100" > $ZATHRCFILE \
    && xdg-mime default zathura.desktop application/pdf
