export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/dotfiles/scripts
export PATH="$HOME/.yarn/bin/:$PATH"
[[ "$OSTYPE" != "darwin"* ]] && export PATH="$HOME/.local/share/swift-4.1.1-RELEASE-ubuntu16.10/usr/bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="/Library/TeX/texbin/:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PGDATA=/usr/local/var/postgres
[[ -f "/etc/arch-release" ]] && export PATH=$PATH:/usr/bin/core_perl/
export MANPATH="/opt/local/share/man:/usr/local/man:$MANPATH"
export EDITOR=vim

export LC_CTYPE=en_US.UTF-8

export PAGER='less'

# export $(dbus-launch)

export PYLINTRC="~/.pylintrc"
export GOPATH="$HOME/.go"
export RUST_SRC_PATH=~/src/rust/src/src
export PATH="$GOPATH/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
export PATH="$JAVA_HOME/bin:$PATH"
#Node version manager:
export NVM_DIR="~/.nvm/"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#This will overwrite ~/.gitconfig
if command_exists nvim ; then
    export GIT_EDITOR=nvim
fi

#Needed for tmuxp?
export DISABLE_AUTO_TITLE='true'
