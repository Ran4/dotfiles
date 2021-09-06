export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/dotfiles/scripts
export PATH="$HOME/.yarn/bin/:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="$PATH:/usr/local/opt/python@3.7/bin"
export PATH="$PATH:/opt/mssql-tools/bin"
export MYPYPATH=${HOME}/.local/share/mypy-path
[[ "$OSTYPE" != "darwin"* ]] && export PATH="$HOME/.local/share/swift-4.1.1-RELEASE-ubuntu16.10/usr/bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="/Library/TeX/texbin/:$PATH"
[[ "$OSTYPE" == "darwin"* ]] && export PGDATA=/usr/local/var/postgres
[[ -f "/etc/arch-release" ]] && export PATH=$PATH:/usr/bin/core_perl/
export MANPATH="/opt/local/share/man:/usr/local/man:$MANPATH"
export EDITOR=vim
export EXPORT PYTHONPYCACHEPREFIX=/tmp/__pycaches

export LC_CTYPE=en_US.UTF-8

export PAGER='less'

# Style for bat https://github.com/sharkdp/bat
# Possible values: auto (default), full, plain, changes, header, grid, numbers.
# Can be combined with e.g. BAT_STYLE=header,numbers
export BAT_STYLE=plain

# export $(dbus-launch)

export PYLINTRC="~/.pylintrc"
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
export PATH="$JAVA_HOME/bin:$PATH"

#This will overwrite ~/.gitconfig
if command_exists nvim ; then
    export GIT_EDITOR=nvim
fi

#Needed for tmuxp?
export DISABLE_AUTO_TITLE='true'
export IS_LOCALHOST="true"
