#!/usr/bin/env bash

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

if [[ "yes" == $(ask_yes_or_no 'Install applications via pacman?')  ]]
then
    echo "Installing...."
    ~/dotfiles/arch/pacman_installs.sh
else
    echo "Not installing any applications via pacman."
fi

echo "Changing shell to zsh..."
sudo chsh -s $(which zsh)
