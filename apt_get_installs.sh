sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install xcape
sudo apt-get -y install openssh-server
sudo apt-get -y install vim-gnome
sudo apt-get -y install tmux
sudo apt-get -y install curl
sudo apt-get -y install ack-grep
sudo apt-get -y install silversearcher-ag
sudo apt-get -y install tree
sudo apt-get -y install feh

sudo apt-get -y install xsel #xsel -p to get primary clipboard, pipe to it to set primary
sudo apt-get -y install xdotool #used with ~/.i3/runorfocus.py
sudo apt-get -y install zsh

sudo apt-get -y install zathura #pdf viewer with vim keybindings
ZATHRCFILE=/etc/zathurarc
[ ! -f $ZATHRCFILE ] \
    && echo "writing $ZATHRCFILE" && echo "set scroll-step 100" > $ZATHRCFILE \
    && xdg-mime default zathura.desktop application/pdf

sudo apt-get -y install python-pip
#sudo apt-get -y install texlive texlive-latex-base # Around 300 MB?
#sudo apt-get -y install texlive-full  # 3 GB...

#sudo apt-get -y install python-tk #used for clip.py

##Installing i3-gaps. Needs i3 first!
#sudo apt-get -y install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev
#sudo apt-get -y install libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev
#sudo apt-get -y install libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
#cd git/other/
#git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && make && sudo make install

