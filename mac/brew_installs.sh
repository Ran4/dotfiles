brew update
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
brew install rsync
brew install unzip
brew install python
brew install vim --override-system-vi
brew install macvim
#brew install macvim --override-system-vim --custom-system-icons
brew install zsh

brew install tmux
brew install wget
brew install htop
brew install tree
brew install the_silver_searcher

brew tap zegervdv/zathura
brew install zathura
brew install zathura-pdf-poppler

# Python stuff
pip install --upgrade pip
brew install freetype
brew install libxml2

# Pygame:
brew tap Homebrew/python
brew update
brew install Homebrew/python/pygame

pip install nose
brew tap homebrew/science
#brew tap samueljohn/python

brew install gcc #needed for Fortran
brew install homebrew/python/numpy --with-openblas

brew install wxpython

brew link numpy
brew install homebrew/python/matplotlib

pip install pandas

brew cask install xquartz

brew install Caskroom/cask/anki

# Things to install manually.
# TODO: automate these things!
#Ukulele:
#http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=ukelele

# Possibly deprecated

#In case --override-system-vi above doesn't work
# Making OS X use brew vim instead of built-in vim
# (to e.g. enable support for +clipboard):
# https://allenan.com/using-the-system-clipboard-with-vim-on-os-x/
# Enter recovery mode (cmd+r during boot), open terminal and write this:
#csrutil disable
#reboot
# then e.g. mv /usr/bin/vim /usr/bin/vim74 to move away the default vim
#brew install vim


