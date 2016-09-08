export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:/opt/local/bin
[[ -f "/etc/arch-release" ]] && export PATH=$PATH:/usr/bin/core_perl/
export MANPATH="/opt/local/share/man:/usr/local/man:$MANPATH"
export EDITOR=vim

export PAGER='less'

export PYLINTRC="~/.pylintrc"
#Node version manager:
export NVM_DIR="/home/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#This will overwrite ~/.gitconfig
if command_exists nvim ; then
    export GIT_EDITOR=nvim
fi
