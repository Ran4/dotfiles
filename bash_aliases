alias ll='ls -l'
alias la='ls -A'
alias l='ls -C'
alias lah='ls -lAh'
alias lg='ls -lAh | ack -i'

alias gits='git status'
#eg. '* 3624854 (HEAD, master) Added gitconfig (23 minutes ago) <Rasmus Ansin>' but colored
alias gl='git log -n 10 --graph --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch -v' #(verbose)
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gch='git checkout'
alias ga='git add'

alias g='grep'
alias gi='grep -i' #case-insensitive grep
alias grepi='grep -i'
alias acki='ack -i'
alias agi='ag -i'

alias matnod='matlab -nosplash -nodesktop'
alias pdf='run zathura'

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

alias logo='lxsession'
alias logout='lxsession'

alias kth='ssh ransin@u-shell.csc.kth.se'
#alias xterm='xterm tmux -2'
alias uxterm='uxterm tmux -2'
alias tmux='tmux -2'
alias xr='xmodmap ~/.xmodmap_swap_caps_and_escape'

alias vims='vim -S .vimsession'
alias vim3='vim -c "vert resize 80" -c "wincmd w" -c "vert resize 80" -c "wincmd W" -O3'
alias vim4="vim -c 'bel vert sbuf 2' -c '1wincmd w' -c 'bel sbuf 3' -c '3wincmd w' -c 'bel sbuf 4'"
alias vims='vim -S .vimsession'

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

alias rmswp='rm .*.swp'
alias rmpyc='rm *.pyc'
alias manvim='function _domanvim() { man $1 | vim -R -; }; _domanvim'
alias :q='exit'
alias :Q='exit'
alias :qa='exit'
alias :Qa='exit'

#alias wanip='curl -s http://whatismijnip.nl |cut -d " " -f 5'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmuxs='~/dotfiles/defaulttmuxsession.sh'
alias ts='~/dotfiles/defaulttmuxsession.sh'
alias tskth='ts && tmux source-file ~/dotfiles/custom/kth_tmux.conf'

#show battery level
alias bat='cat /sys/class/power_supply/BAT1/capacity'

alias reset='reset && tmux clear-history'
alias clear='clear && tmux clear-history'

#temporary: used to quickly edit i3 config
alias ei='vim ~/.i3/config'
#alias kxt="ps aux | grep -i xterm | awk {'print $2'} | xargs kill -9" #kill xterm, please remove me once you've figured out the problem with i3
alias kxt="kill -9 $(pidof xterm)" #kill all xterm windows, please remove me once you've figured out the problem with i3
alias nocaps="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias NOCAPS="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
