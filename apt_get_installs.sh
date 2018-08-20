sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install openssh-server
sudo apt-get -y install sshfs
sudo apt-get -y install vim-gnome
sudo apt-get -y install tmux
sudo apt-get -y install curl
sudo apt-get -y install ack-grep
sudo apt-get -y install silversearcher-ag
sudo apt-get -y install pandoc
sudo apt-get -y install pandoc-citeproc
sudo apt-get -y install httpie
sudo apt-get -y install tree
sudo apt-get -y install ncdu
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
    sudo apt-get -y install imwheel #used to e.g. speed up mouse scroll speed in zathura
    ZATHRCFILE=/etc/zathurarc
    [ ! -f $ZATHRCFILE ] \
        && echo "writing $ZATHRCFILE" && sudo echo "set scroll-step 100" > $ZATHRCFILE \
        && xdg-mime default zathura.desktop application/pdf
fi
sudo apt-get -y install zsh

sudo apt-get -y install python-pip

# Git, `apt install git` will install an older version
sudo apt-add-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

# Neovim
sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:neovim-ppa/unstable && \
    sudo apt-get update && \
    sudo apt-get -y install neovim && \
    pip3 install neovim && \
    pip2 install neovim

sudo apt-get -y install python-dev python-pip python3-dev python3-pip

sudo apt-get -y install ruby-dev

#The symlinking is done in makesymlinks.sh

#sudo apt-get -y install texlive texlive-latex-base # Around 300 MB?
#sudo apt-get -y install texlive-full  # 3 GB...

#used for clip.py
sudo apt-get -y install python-tk

# volume control and e.g. setting microphone input
sudo apt -y install pavucontrol

# Used by caps2esc
sudo apt-get install -y libudev-dev
git clone https://github.com/oblitum/caps2esc ~/git/other/caps2esc/

##Installing i3-gaps. Needs i3 first!
# Dependencies has been updated, and are rather complicated for ubuntu. See the project wiki for install
# instructions
# cd git/other/
# git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && make && sudo make install
