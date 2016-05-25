#!/usr/bin/env bash
dir=~/dotfiles                    # dotfiles directory

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

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

if [[ "yes" == $(ask_yes_or_no 'Install applications via pacman?')  ]]
then
    echo "Installing...."
    ~/dotfiles/arch/pacman_installs.sh
fi

# echo "Changing shell to zsh..."
# sudo chsh -s $(which zsh)

echo -e "${LBLUE}Creating symlink to ~/.zprofile (ln -s $dir/arch/zprofile ~/.zprofile)${NC}"
ln -sf $dir/arch/zprofile ~/.zprofile
echo "...done"

echo -e "${LBLUE}Copying $dir/arch/locale.conf to /etc/locale.conf${NC}"
sudo cp $dir/arch/locale.conf /etc/locale.conf
echo "...done"
