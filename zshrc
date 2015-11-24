# Path to your oh-my-zsh installation.
export ZSH=/home/ran/.oh-my-zsh

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/ran/.fzf/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
bindkey '^r' history-incremental-search-backward
bindkey '^f' accept-line
bindkey -M viins 'jk' vi-cmd-mode
export KEYTIMEOUT=1 #this is in 10 ms steps, so e.g. 20 = 200 ms
#Found at: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#Don't autocomplete hosts.
#Inspiration: https://tlvince.com/fixing-slow-zsh-command-completion
zstyle ':completion:*' hosts off

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #command line fuzzy file finder
[ -f ~/git/z/z.sh ] && source ~/git/z/z.sh


#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

#Key delay. msDelay (higher=longer), rate (quicker=faster)
set r rate 230 70
if command_exists xset ; then
    xset r rate 230 70 &> /dev/null ;
fi

#############################################################
##COMPUTER-SPECIFIC CONFIG:

#disable touchpad on thinkpad computers
if [ -f ~/.identifiers/ranl412 ]; then
    #Disable TouchPad:
    declare -i ID
    ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
    xinput set-prop $ID "Device Enabled" 0
    #echo 'Touchpad has been disabled.'
    
    #Increase speed of trackpoint. Default is 1.0, 0.9 is faster
    TRACKPOINT_NAME=$(xinput --list --name-only | g -i trackpoint)
    xinput --set-prop "$TRACKPOINT_NAME" "Device Accel Constant Deceleration" 0.9
fi

if [ -f ~/.identifiers/ranlubuntu ]; then
    #alias m='~/ovrigt/mount_vbshare.sh'
    alias m='~/ovrigt/mount_all.sh'
fi

if command_exists xcape ; then
    . ~/.xcape_config
    #echo "Not running xcape config!"
else
    xmodmap ~/.xmodmap_swap_caps_and_ctrl &> /dev/null ;
    #echo "Not running xmodmap!"
fi

setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"
