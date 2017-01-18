sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install openssh-server
sudo apt-get -y install vim-gnome
sudo apt-get -y install tmux
sudo apt-get -y install curl
sudo apt-get -y install ack-grep
sudo apt-get -y install silversearcher-ag
sudo apt-get -y install tree
if [ -f ~/.identifiers/without_x ] ; then
    echo 'Ignoring X programs, please run:'
    echo '#sudo rm -rf $(which xset)'
    echo '#sudo rm -rf $(which xmodmap)'
    echo '#sudo rm -rf $(which setxkbmap)'
else
    sudo apt-get -y install xcape
    sudo apt-get -y install feh
    sudo apt-get -y install xsel #xsel -p to get primary clipboard, pipe to it to set primary
    sudo apt-get -y install xdotool #used with ~/.i3/runorfocus.py

    sudo apt-get -y install zathura #pdf viewer with vim keybindings
    ZATHRCFILE=/etc/zathurarc
    [ ! -f $ZATHRCFILE ] \
        && echo "writing $ZATHRCFILE" && sudo echo "set scroll-step 100" > $ZATHRCFILE \
        && xdg-mime default zathura.desktop application/pdf
fi
sudo apt-get -y install zsh

sudo apt-get -y install python-pip

# Git, `apt install git` will install an older version
sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# Neovim
sudo apt-get install software-properties-common && \
    sudo add-apt-repository ppa:neovim-ppa/unstable && \
    sudo apt-get update && \
    sudo apt-get -y install neovim && \
    pip3 install neovim && \
    pip2 install neovim

sudo apt-get -y install python-dev python-pip python3-dev python3-pip
#The symlinking is done in makesymlinks.sh

#sudo apt-get -y install texlive texlive-latex-base # Around 300 MB?
#sudo apt-get -y install texlive-full  # 3 GB...

#used for clip.py
sudo apt-get -y install python-tk

##Installing i3-gaps. Needs i3 first!
#sudo apt-get -y install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev
#sudo apt-get -y install libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev
#sudo apt-get -y install libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
#cd git/other/
#git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && make && sudo make install

