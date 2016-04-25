brew update
################################################################################
# Common linux stuff
################################################################################
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
brew install zsh
brew install rsync
brew install unzip
brew install python
brew install python3
brew install vim --override-system-vi
brew install macvim
#brew install macvim --override-system-vim --custom-system-icons
brew install tmux
brew install wget
brew install htop
brew install tree
brew install the_silver_searcher
brew install ack

brew install youtube-dl

################################################################################
# Python installs
################################################################################
pip install --upgrade pip
pip install virtualenv
pip install bpython
brew install freetype
brew install libxml2


brew tap Homebrew/python
brew install Homebrew/python/pygame

brew tap homebrew/science
brew update

pip install nose #nose tests
#brew tap samueljohn/python
brew install gcc #needed for Fortran
brew install homebrew/python/numpy --with-openblas

brew install wxpython
brew link numpy
brew install homebrew/python/matplotlib
pip install pandas
pip install pep8

################################################################################
# Brew cask installs
################################################################################
brew cask install xquartz

#fonts
brew cask install caskroom/fonts/font-hack

brew install Caskroom/cask/anki
brew cask install flip4mac #Needed to play wmv files on OS X
brew cask install silverlight
brew cask install vlc
brew cask install broomstick #Hide menu bar items
brew cask install slack #The chat program
brew cask install mendeley-desktop

################################################################################
# Fixes
################################################################################

#Fixes problem with using the open command in tmux
#(found at https://www.elmund.io/osx/2015/07/10/open-command-in-osx-tmux/)
brew install reattach-to-user-namespace
#run this:
# echo "set -g default-command \"reattach-to-user-namespace -l ${SHELL}\"" >> ~/.tmux.conf


################################################################################
# Manual installs
################################################################################

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
