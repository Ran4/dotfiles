# Path to your oh-my-zsh installation.
#export ZSH=/home/ran/.oh-my-zsh
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
# If set to "random", load a random theme each time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
ZSH_THEME="sunrise-modified-ran"

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

HISTSIZE=400000
HISTFILESIZE=8000000

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode)

# User configuration
#export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/ran/.fzf/bin"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

#Don't autocomplete hosts.
#Inspiration: https://tlvince.com/fixing-slow-zsh-command-completion
zstyle ':completion:*' hosts off

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}
#{{{Keyboard related
source $ZSH/oh-my-zsh.sh
bindkey '^r' history-incremental-search-backward
#bindkey '^f' accept-line
bindkey -M viins 'jk' vi-cmd-mode
export KEYTIMEOUT=1 #this is in 10 ms steps, so e.g. 20 = 200 ms
#Found at: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#Key delay. msDelay (higher=longer), rate (quicker=faster)
set r rate 230 70
if command_exists xset ; then
    xset r rate 230 70 &> /dev/null ;
fi

#Prevent <c-s> from stopping the terminal
#stty -ixon
#}}}

#Node version manager:
export NVM_DIR="/home/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #command line fuzzy file finder
[ -f ~/git/z/z.sh ] && source ~/git/z/z.sh
[ -f ~/.hhighlighter.sh ] && source ~/.hhighlighter.sh && alias h='h -n'

#alias ls='ls --group-directories-first -hF' #human readable, append indicator (one of */=>@|)
# Colors {{{
if [ -x /usr/bin/dircolors ]; then
    #if we can read the file ~/.dircolors, then eval list of colors given by $(dircolors -b ~/.dircolors)
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -hF' #color, human readable, append indicator (one of */=>@|)
elif [ -x /usr/local/bin/gdircolors ]; then #OS X
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto -hF' #color, human readable, append indicator (one of */=>@|)
fi

# Color for less {{{
# See http://misc.flogisoft.com/bash/tip_colors_and_formatting for colors
#export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
#01 bold, 35 magenta
export LESS_TERMCAP_md=$'\E[01;35m'      # begin bold: color for NAME, SYNOPSIS, DESCRIPTION...
export LESS_TERMCAP_me=$'\E[0m'          # end mode
#04 underline, 92 light green
#export LESS_TERMCAP_so=$'\E[04;92m'   # begin standout-mode - Search highlighting
#export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
#45 bg=magenta
export LESS_TERMCAP_so=$'\E[04;45m'   # begin standout-mode - Search highlighting
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
#export LESS_TERMCAP_us=$'\E[01;45m'      # begin underline: color for commands etc.
#export LESS_TERMCAP_ue=$'\E[0m'      # begin underline: color for commands etc.
#}}}}}}
##COMPUTER-SPECIFIC CONFIG: {{{

#disable touchpad on thinkpad computers
if [ -f ~/.identifiers/ranl412 ]; then
    #. ~/.custom/ranl412_bash_setprompt
    #unlink ~/.tmux.conf
    #ln -s ~/.custom/ranl412_tmux.conf ~/.tmux.conf
    
    #Disable TouchPad:
    declare -i ID
    ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
    xinput set-prop $ID "Device Enabled" 0
    #echo 'Touchpad has been disabled.'
    
    #Increase speed of trackpoint. Default is 1.0, 0.9 is faster
    TRACKPOINT_NAME=$(xinput --list --name-only | g -i trackpoint)
    xinput --set-prop "$TRACKPOINT_NAME" "Device Accel Constant Deceleration" 0.9
    
    feh --bg-scale ~/ovrigt/backgrounds/space_bluedots_1366_768.jpg
    
    #Set screen layout for 21.5" and rotated 24" screens at SciLifeLab
    alias ki='~/.screenlayout/ki_215_24r.sh'
    alias kih='~/.screenlayout/ki_high215_24r.sh'
    alias ki2='~/.screenlayout/ki_24r_24r.sh'
fi

if [ -f ~/.identifiers/ranlubuntu ]; then
    #alias m='~/ovrigt/mount_vbshare.sh'
    alias m='~/ovrigt/mount_all.sh'
    
    feh --bg-scale ~/other/backgrounds/Rainbow-Sky-Wallpaper-1024x576.jpg
fi

if [ -f ~/.identifiers/ran-main-kubuntu ]; then
    #set background image:
    #feh --bg-scale ~/other/backgrounds/red-shine.jpg
    feh --bg-scale ~/other/backgrounds/waterfall_pixely.png
fi

#Mac-specific stuff
if [ -f ~/.identifiers/mac ]; then 
    
fi
#}}}

if command_exists setxkbmap ; then
    #setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"
    setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin" -option ctrl:nocaps
fi

if command_exists xcape ; then
    . ~/.xcape_config
    #echo "Not running xcape config!"
else
    if command_exists xmodmap ; then
        xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
        #echo "Not running xmodmap!"
    fi
fi
