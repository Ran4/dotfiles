sudo apt-get update
sudo apt-get -y install git xcape openssh-server vim-gnome tmux
sudo apt-get -y install curl ack-grep silversearcher-ag
sudo apt-get install silversearcher-ag

sudo apt-get -y install xsel #xsel -p to get primary clipboard, pipe to it to set primary
sudo apt-get -y install zsh

sudo apt-get -y install zathura #pdf viewer with vim keybindings
ZATHRCFILE=/etc/zathurarc
[ ! -f $ZATHRCFILE ] && echo "writing to $ZATHRCFILE" && echo "set scroll-step 100" > $ZATHRCFILE

sudo apt-get -y install python-pip
#sudo apt-get -y install texlive texlive-latex-base # Around 300 MB?
#sudo apt-get -y install texlive-full  # 3 GB...

git config --global user.email "rasmus.ansin@gmail.com"
git config --global user.name "Rasmus Ansin"
git config --global push.default simple
#use less as a pager, but only if output is longer than the screen
git config --global --replace-all core.pager "less -F -X"

#Make a copy of the default ssh config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
mkdir -p ~/.ssh

mkdir -p ~/git/other

#Remove annoying folders that come with ubuntu
rmdir ~/Music
rmdir ~/Pictures
rmdir ~/Documents
rmdir ~/Videos
rmdir ~/Desktop

mkdir -p ~/pyy
#cd ~/pyy
#git clone git@github.com:Ran4/ei.git
#sudo cp ~/pyy/ei/ei.py /usr/lib/python2.7/

#sudo apt-get -y install python-tk #used for clip.py

#sudo apt-get --reinstall install msttcorefonts
#sudo apt-get --reinstall install ttf-mscorefonts-installer

#i3-gaps. Needs i3 first!
#sudo apt-get -y install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev
#sudo apt-get -y install libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev
#sudo apt-get -y install libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
#cd git/other/
#git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && make && sudo make install
