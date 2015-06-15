sudo apt-get -y install git
sudo apt-get -y install vim
sudo apt-get -y install tmux
sudo apt-get -y install curl

mkdir -p ~/pyy

#get ei
cd ~/pyy
git clone git@github.com:Ran4/ei.git

sudo cp ~/pyy/ei/ei.py /usr/lib/python2.7/

#used for clip.py
sudo apt-get -y install python-tk

