sudo apt install -y exuberant-ctags cmake libevent-dev libncurses5-dev automake
git clone https://github.com/tmux/tmux /tmp/tmux
cd /tmp/tmux
sh autogen.sh
./configure && make
sudo make install
