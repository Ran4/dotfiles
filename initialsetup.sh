sudo apt-get -y install git
sudo apt-get -y install openssh-server
sudo apt-get -y install vim-gnome
sudo apt-get -y install tmux
sudo apt-get -y install curl

git config --global user.email "rasmus.ansin@gmail.com"
git config --global user.name "Rasmus Ansin"
git config --global push.default simple

#Make a copy of the default ssh config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults

#Remove annoying folders that come with ubuntu
rmdir ~/Music
rmdir ~/Pictures
rmdir ~/Documents
rmdir ~/Videos
rmdir ~/Desktop

mkdir -p ~/pyy
cd ~/pyy
#git clone git@github.com:Ran4/ei.git
#sudo cp ~/pyy/ei/ei.py /usr/lib/python2.7/

#sudo apt-get -y install python-tk #used for clip.py

