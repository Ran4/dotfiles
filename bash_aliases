# vim: ft=sh

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    #'Running GNU coreutils via Homebrew on your Mac? Here's a one-liner to get the manpages working!'
    #https://gist.github.com/quickshiftin/9130153
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
    alias sort='gsort'
fi

alias ll='ls --group-directories-first -l'
alias la='ls --group-directories-first -A'
alias l='ls --group-directories-first -C'
alias lah='ls --group-directories-first -lAh'
alias laht='ls -lAht'
alias lg='ls -lAh | ack -i'

alias gits='git status'
#eg. '* 3624854 (HEAD, master) Added gitconfig (23 minutes ago) <Rasmus Ansin>' but colored
alias gl='git log -n 10 --graph --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias ghostscript='/opt/local/bin/gs'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch -v' #verbose
alias gba='git branch -av' #(all, verbose)
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gch='git checkout'
alias ga='git add'

#Program aliases
alias g='grep'
alias gi='grep -i' #case-insensitive grep
alias grepi='grep -i'
alias acki='ack -i'
alias agi='ag -i'

alias tmux='tmux -2'
alias matnod='matlab -nosplash -nodesktop' #Run CLI version of Matlab
alias pdf='run zathura'
alias arq='/home/ran/.jena/apache-jena-3.0.1/bin/arq' #arq, for running SPARQL queries
#alias lo='libreoffice'

lo() {
    (libreoffice $@ &> /dev/null &)
}

run() {
    ($@ &> /dev/null &)
}

o() {
    (xdg-open $@ &> /dev/null &)
}

function __cdls {
    cd $1
    ls
}

alias c='__cdls'
alias c..='__cdls ..'
alias cl='__cdls'
alias cdl='__cdls'
alias cdls='__cdls'
alias cd..='cd ..'
alias cd...='cd ...'
alias cd....='cd ....'
alias cd.....='cd .....'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias sagi='sudo apt-get install'
alias acs='apt-cache search'

alias logo='lxsession'
alias logout='lxsession'

#Send files to vimserver (creating one called VIMR automatically if needed).
function vimr {
SERVER_NAME=VIMRSERVER
vim --serverlist | grep -q $SERVER_NAME
if [ $? -eq 0 ]; then #a server has been started
    #echo "Found VIMRSERVER"
    if [ $# -eq 0 ]; then #no arguments given, start regular vim
        #echo "No arguments given, starting vim as usual"
        vim
    else
        #echo "Trying to access server called $SERVER_NAME"
        #vim --servername $SERVER_NAME --remote "$@"
        vim --servername $SERVER_NAME --remote-tab "$@"
    fi
else #start a new server
    #echo "Starting new server called $SERVER_NAME"
    vim --servername $SERVER_NAME "$@"
fi
}

#metal archives lyrics search: mly
if [ -f ~/git/other/metallum/metallum.py ]; then
    alias mly='python ~/git/other/metallum/metallum.py'
    
    if [ -f ~/dotfiles/scripts/mly_nowplaying.sh ]; then
        alias ly='~/dotfiles/scripts/mly_nowplaying.sh'
    fi
fi

alias rmpyc='rm *.pyc'
alias rmswp='rm .*.swp'
alias manvim='function _domanvim() { man $1 | vim -R -; }; _domanvim'
alias vims='vim -S .vimsession'
alias vim3='vim -c "vert resize 80" -c "wincmd w" -c "vert resize 80" -c "wincmd W" -O3'
alias vim4="vim -c 'bel vert sbuf 2' -c '1wincmd w' -c 'bel sbuf 3' -c '3wincmd w' -c 'bel sbuf 4'"
alias vims='vim -S .vimsession'
alias :q='exit'
alias :Q='exit'
alias :qa='exit'
alias :Qa='exit'

alias treei='tree -I "*.pyc" --matchdirs -I "__pycache__"'

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmuxs='~/dotfiles/defaulttmuxsession.sh'
alias ts='~/dotfiles/defaulttmuxsession.sh'
alias tskth='ts && tmux source-file ~/dotfiles/custom/kth_tmux.conf'

#show battery level
alias bat='cat /sys/class/power_supply/BAT1/capacity'

alias reset='reset && tmux clear-history'
alias clear='clear && tmux clear-history'
alias lock='i3lock -d --color=102010 --no-unlock-indicator' #-d suspends screen after default 30s

#temporary: used to quickly edit i3 config
alias ei='vim ~/.i3/config'
#alias kxt="ps aux | grep -i xterm | awk {'print $2'} | xargs kill -9" #kill xterm, please remove me once you've figured out the problem with i3
alias nocaps="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias NOCAPS="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
