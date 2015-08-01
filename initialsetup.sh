sudo apt-get -y install git openssh-server vim-gnome tmux curl
sudo apt-get -y install xsel #xsel -p to get primary, pipe to it to set primary
sudo apt-get -y install python-pip
#sudo apt-get -y install texlive texlive-latex-base # Around 300 MB?
#sudo apt-get -y install texlive-full  # 3 GB...

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

#FZF, a Fuzzy file finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
