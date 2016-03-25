#Brew stuff
#Common linux stuff
brew tap homebrew/dupes
brew install findutils --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls --with-default-names
brew install grep --with-default-names
brew install coreutils --with-default-names
brew install binutils
brew install diffutils
brew install gzip
brew install watch

brew install git
brew install less
brew install openssh
brew install python
brew install rsync
brew install unzip
brew install vim --override-system-vi
#brew install macvim --override-system-vim --custom-system-icons
brew install zsh

brew install tmux
brew install wget
brew install htop
brew install tree
brew install the_silver_searcher

#In case --override-system-vi above doesn't work
# Making OS X use brew vim instead of built-in vim
# (to e.g. enable support for +clipboard):
# https://allenan.com/using-the-system-clipboard-with-vim-on-os-x/
# Enter recovery mode (cmd+r during boot), open terminal and write this:
#csrutil disable
#reboot
# then e.g. mv /usr/bin/vim /usr/bin/vim74 to move away the default vim
#brew install vim


