# vim: ft=sh
#Help functions {{{
#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

run() {
    ($@ &> /dev/null &)
}

#}}}
#OS X specific {{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    #'Running GNU coreutils via Homebrew on your Mac? Here's a one-liner to get the manpages working!'
    #https://gist.github.com/quickshiftin/9130153
    # alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
    alias sort='gsort'
    alias firefox='open -a firefox -g' #open application (-a) firefox, don't bring it to foreground (-g)
fi
#}}}
#ls {{{
alias ll='ls --group-directories-first -l'
alias la='ls --group-directories-first -A'
alias l='ls --group-directories-first -C'
alias lah='ls --group-directories-first -lAh'
alias laht='ls -lAht'
alias lg='ls -lAh | ack -i'
#}}}
#git {{{
alias gits='git status'
#eg. '* 3624854 (HEAD, master) Added gitconfig (23 minutes ago) <Rasmus Ansin>' but colored
alias gl='git log -n 16 --graph --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias ghostscript='/opt/local/bin/gs'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gu='git pull --rebase'
alias gd='git diff'
alias gdw='git diff --color-words=.'
alias gdc='git diff --cached'
alias gdwc='git diff --color-words=. --cached'
alias gb='git branch -v' #verbose
alias gba='git branch -av' #(all, verbose)
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gch='git checkout'
alias ga='git add'
#}}}
#cd aliases {{{
function __cdls {
    cd $1
    ls
}
# alias c='__cdls'
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
#end of cd aliases }}}
#Program aliases {{{

#Libreoffice help function
lo() {
    (libreoffice $@ &> /dev/null &)
}

alias g='grep'
alias gi='grep -i' #case-insensitive grep
alias grepi='grep -i'
alias acki='ack -i'
alias agi='ag -i'

alias matnod='matlab -nosplash -nodesktop' #Run CLI version of Matlab
alias hask="stack --verbosity silent runghc"

alias tree='tree --dirsfirst -I "*.pyc" --matchdirs -I "__pycache__" -I node_modules'

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ccat='pygmentize -O bg=dark'

if [[ "$OSTYPE" != "darwin"* ]]; then
    alias scala='sbt console'
fi
alias tmuxs='~/dotfiles/defaulttmuxsession.sh'
alias ts='~/dotfiles/defaulttmuxsession.sh'
alias work='sess work'
alias sess='~/dotfiles/sess.sh'
# alias tns='tmux new -s' #Create new session with tns sessionname
alias t='~/dotfiles/tmux_attach_to_or_create_new_session.bash' #Create new session $1 or attach to it
alias tskth='ts && tmux source-file ~/dotfiles/custom/kth_tmux.conf'

# Django manage.py
alias m='./manage.py'

# Docker
alias docker-clean='docker container prune -f; docker image prune -f'
alias dockerip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

alias du='du -h' #-h human readable
alias dus='du -sch * | sort -h' #-s no recursive show, -c show total, -h human readable

if command_exists apt-get ; then
    alias sagi='sudo apt-get install'
    alias i='sudo apt-get install'
    alias s='apt-cache search'
    alias acs='apt-cache search'
fi

if command_exists pacman ; then
    alias sps='sudo pacman -S'
fi

alias logo='lxsession'
alias logout='lxsession'
#alias va='source .venv/bin/activate' #virtualenv activate
alias va='[[ -f .venv/bin/activate ]] && source .venv/bin/activate || ([[ -f Pipfile ]] && pipenv shell || source ../.venv/bin/activate)' #virtualenv activate
#Lyrics associated aliases and functions {{{
#metal archives lyrics search: mly
if [ -f ~/git/other/metallum/metallum.py ]; then
    alias mly='python ~/git/other/metallum/metallum.py'

    if [ -f ~/dotfiles/scripts/mly_nowplaying.sh ]; then
        alias ly='~/dotfiles/scripts/mly_nowplaying.sh'
    fi
fi
if [ -f ~/git/other/metallum/metallum.py ]; then
    alias lya='clear && ~/dotfiles/scripts/lyrics_shower.py'
fi
#}}}
#Vim associated aliases {{{
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

alias rmpyc='rm **/*__pycache__'
alias rmswp='rm .*.swp'
alias manvim='function _domanvim() { man $1 | vim -R -; }; _domanvim'
alias http='http --style fruity'
alias vims='vim -S .vimsession'
alias vim3='vim -c "vert resize 80" -c "wincmd w" -c "vert resize 80" -c "wincmd W" -O3'
alias vim4="vim -c 'bel vert sbuf 2' -c '1wincmd w' -c 'bel sbuf 3' -c '3wincmd w' -c 'bel sbuf 4'"
alias vims='vim -S .vimsession'
alias vim='vim -O' #open multiple files as vertical splits by default
if command_exists nvim ; then
    if [ -f /usr/local/bin/vim ]; then
        alias vi='/usr/local/bin/vim -O'
    else
        alias vi='/usr/bin/vim -O'
    fi
    alias vim='nvim -O'
fi
alias :q='exit'
alias :Q='exit'
alias :qa='exit'
alias :Qa='exit'
#}}}
#end of Program aliases }}}
alias p3='python3'

# "pandas play"
alias pp='source ~/src/pyy/play/pandas/.venv/bin/activate && python3 -i ~/src/pyy/play/pandas/go.py; deactivate'

alias zath='zathura'
alias prettyjson='python3 -m json.tool'
alias glances='glances --percpu'
alias transfer='rsync -ah --progress'

if command_exists tmux ; then
    alias reset='reset && tmux clear-history'
    alias clear='clear && tmux clear-history'
fi
if command_exists i3lock ; then
    alias lock='i3lock -d -e --color=102010' #-d suspends screen after default 30s,
    #-e ignores empty password
fi

#KWM, a tiling window manager for OS X
if command_exists kwmc ; then
    alias kwmkill='launchctl unload /usr/local/opt/kwm/homebrew.mxcl.kwm.plist'
    alias kwmstart='launchctl load /usr/local/opt/kwm/homebrew.mxcl.kwm.plist'
    # Kwm restart = kr
    alias kr='kwmkill && kwmstart'
    #-e ignores empty password
fi

#alias kxt="ps aux | grep -i xterm | awk {'print $2'} | xargs kill -9" #kill xterm, please remove me once you've figured out the problem with i3
alias nocaps="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias NOCAPS="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias capsoff="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias CAPSOFF="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"

alias pyproj=". ~/.tmuxp/pyproj.sh"


if [ -f ~/.identifiers/orexplore ]; then
    # Screen layouts:
    # alias xrm="~/.screenlayout/T460s_and_1920x1200.sh"
    alias xrmain="~/.screenlayout/T460s_and_4k.sh"

    # alias xrs="~/.screenlayout/same_T460s_and_1920x1080.sh"
    alias xrsame="~/.screenlayout/same_T460s_and_1920x1080.sh"
    alias xrsamedp="~/.screenlayout/same_T460s_and_1920x1080_minidp.sh"

    alias xrone="~/.screenlayout/T460s_only.sh"

    # Docker exec shortcuts
    alias web='docker exec -it $(docker-compose ps -q web)'
fi

if [ -f ~/.identifiers/ran-ub ]; then
    alias xrmain="~/.screenlayout/main.sh"
fi

alias exp="source /tmp/export"
alias twitch='nohup google-chrome --app=https://www.twitch.tv/escapeaoe/videos/all &'
alias netflix='nohup google-chrome --app=https://www.netflix.com &'

alias curlj='curl -H "Content-Type: application/json" -H "Accept: application/json; indent=4"'
alias typora='open -a typora'
