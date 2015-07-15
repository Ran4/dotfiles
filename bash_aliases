alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias logout='gnome-session-quit --force'

alias gits='git status'
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'

alias cd..='cd ..'
alias ..='cd ..'

alias kth='ssh ransin@u-shell.csc.kth.se'
#alias xterm='xterm tmux -2'
alias uxterm='uxterm tmux -2'
alias tmux='tmux -2'
alias xr='xmodmap ~/.xmodmap_swap_caps_and_escape'

alias vims='vim -S .vimsession'
alias vim3='vim -c "vert resize 80" -c "wincmd w" -c "vert resize 80" -c "wincmd W" -O3'
alias vim4="vim -c 'bel vert sbuf 2' -c '1wincmd w' -c 'bel sbuf 3' -c '3wincmd w' -c 'bel sbuf 4'"
alias vims='vim -S .vimsession'
alias rmswp='rm .*.swp'
alias manvim='function _domanvim() { man $1 | vim -R -; }; _domanvim'

#alias wanip='curl -s http://whatismijnip.nl |cut -d " " -f 5'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmuxs='~/dotfiles/defaulttmuxsession.sh'
alias ts='~/dotfiles/defaulttmuxsession.sh'
