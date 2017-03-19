export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:~/.local/bin
export PATH="$HOME/.cargo/bin:$PATH"
[[ -f "/etc/arch-release" ]] && export PATH=$PATH:/usr/bin/core_perl/
export MANPATH="/opt/local/share/man:/usr/local/man:$MANPATH"
export EDITOR=vim
export HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"

export LC_CTYPE=en_US.UTF-8

export PAGER='less'

# export $(dbus-launch)

export PYLINTRC="~/.pylintrc"
#Node version manager:
export NVM_DIR="~/.nvm/"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#This will overwrite ~/.gitconfig
if command_exists nvim ; then
    export GIT_EDITOR=nvim
fi

#Needed for tmuxp?
export DISABLE_AUTO_TITLE='true'
