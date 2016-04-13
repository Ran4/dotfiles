function ask_yes_or_no() {
    #found at http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
    #Usage example:
    #if [[ "no" == $(ask_yes_or_no "Are you sure?") || \
    #      "no" == $(ask_yes_or_no "Are you *really* sure?") ]]
    #then
    #    echo "Skipped."
    #    exit 0
    #fi
    read -p "$1 [y]es/[N]o: "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

################# Reduce animations
#Disable opening and closing window animations
defaults write GlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

#Increase window resize speed for Cocoa applications.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

#Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
#################

#Increase keyboard repeat speed
defaults write -g InitialKeyRepeat -int 14
defaults write -g KeyRepeat -int 1


#Install slate, to bind hyper key (cmd+ctrl+shift+option)
#cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz

mkdir -p ~/.custom
mkdir -p ~/.identifiers
touch ~/.identifiers/mac

if [[ "yes" == $(ask_yes_or_no 'Install applications via brew and macports?')  ]]
then
    echo "Installing...."
    ~/dotfiles/mac/brew_installs.sh
    ~/dotfiles/mac/macport_installs.sh
else
    echo "Not doing brew and macports installs."
fi
