#ZSH related configuration {{{
export ZSH=~/.oh-my-zsh
# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="random"
ZSH_THEME="sunrise-modified-ran"
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd" # Command execution time stamp shown in the history command output.
HISTSIZE=400000
HISTFILESIZE=8000000

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

# plugins loaded from ~/.oh-my-zsh/plugins/*, custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode docker)

source ~/.zsh/exports.zsh
source ~/.zsh/functions.zsh

#Don't autocomplete hosts. Inspiration: https://tlvince.com/fixing-slow-zsh-command-completion
zstyle ':completion:*' hosts off
source ~/.zsh/setopt.zsh
#End of ZSH related configuration }}}
#Keyboard related {{{
source $ZSH/oh-my-zsh.sh
bindkey '^r' history-incremental-search-backward
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

#^p/^n or up/down will search previous line based on what's written,
#e.g. 'vim^p' -> 'vim file.py'
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

#Sometimes, emacs-style keybindings are nice
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^b' vi-backward-char
bindkey '^f' vi-forward-char
bindkey '^d' vi-delete-char
bindkey '^k' vi-kill-eol
bindkey "\eb" vi-backward-word
bindkey "\ef" vi-forward-word
bindkey "\ed" kill-word

#Arrows keys up/down
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

bindkey -M viins 'jk' vi-cmd-mode
export KEYTIMEOUT=1 #this is in 10 ms steps, so e.g. 20 = 200 ms
#Found at: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'

#Key delay. msDelay (higher=longer), rate (quicker=faster)
set r rate 200 70
if command_exists xset ; then
    xset r rate 200 70 &> /dev/null ;
fi

#Prevent <c-s> from stopping the terminal
#stty -ixon

if command_exists setxkbmap ; then
    if [ -n "$DISPLAY" ]; then
        if [ -f "/etc/arch-release" ]; then
            setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"
        else
            # setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin" -option ctrl:nocaps
            setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"
        fi
    fi
fi

# xcape/xmodmap can be used instead of alexandre/caps2esc
#if command_exists xcape ; then
#    . ~/.xcape_config
#    #echo "Not running xcape config!"
#else
#    if command_exists xmodmap ; then
#        if [ ! -f "/etc/arch-release" ]; then
#            xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
#            #echo "Not running xmodmap!"
#        fi
#    fi
#fi

# nohup sudo ./caps2esc &


#}}}
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_exports ] && source ~/.bash_exports
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #command line fuzzy file finder
[ -f ~/git/z/z.sh ] && source ~/git/z/z.sh
[ -f ~/.hhighlighter.sh ] && source ~/.hhighlighter.sh && alias h='h -n'
# [ -f ~/.mpdasrc ] && mpdas -c ~/.mpdasrc -d

#open pdf by simply typing it's name.
alias -s pdf=open

#alias ls='ls --group-directories-first -hF' #human readable, append indicator (one of */=>@|)
# Colors {{{
if [ -x /usr/bin/dircolors ]; then
    #if we can read the file ~/.dircolors, then eval list of colors given by $(dircolors -b ~/.dircolors)
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -hF --group-directories-first' #color, human readable, append indicator (one of */=>@|)
elif [ -x /usr/local/bin/gdircolors ]; then #OS X
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto -hF --group-directories-first' #color, human readable, */=>@| type indicator
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
if [ -f ~/.identifiers/thinkpad ]; then
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
    
    
    if [ -f ~/.identifiers/orexplore ]; then
        feh --bg-scale /usr/share/wallpapers/Next/contents/images/2560x1600.png
        # ~/.screenlayout/T460s_and_1920x1200.sh
    else
        feh --bg-scale ~/other/backgrounds/beautiful_landscape.jpg
    fi
        
    #Set screen layout for 21.5" and rotated 24" screens at SciLifeLab
    alias ki='~/.screenlayout/ki_215_24r.sh'
    alias kih='~/.screenlayout/ki_high215_24r.sh'
    alias ki2='~/.screenlayout/ki_24r_24r.sh'
fi

if [ -f ~/.identifiers/orexplore ]; then
    # Open the erm system
    alias erp='open ~/svn/doc/Artiklar/Orexplores_ERP_system.ods'
    alias cderp='cd ~/svn/doc/Artiklar/'
fi

if [ -f ~/.identifiers/ran-ub1610-vb ]; then
    if [ -n "$DISPLAY" ]; then
        #set background image:
        feh --bg-scale ~/other/backgrounds/house_on_water_1920_1080.jpg    
    fi
    
    #Change tmux bgcolor without changing tmux.conf:
    tmux set -g status-bg '#343d46'
 
    # oh-my-zsh right prompt
    export RPROMPT=$(hostname)
fi

if [ -f ~/.identifiers/ran-ub ]; then
    if [ -n "$DISPLAY" ]; then
        #set background image:
        feh --bg-scale ~/other/backgrounds/lake_and_ocean_bg.jpg
    fi
fi

#Mac-specific stuff
if [[ "$OSTYPE" =~ ^darwin ]]; then
    source ~/dotfiles/mac/zshrc_mac.sh
fi

if [ -f "/etc/arch-release" ]; then
    source ~/dotfiles/arch/zshrc_arch.sh
fi
#}}}
#e.g. "~/Applications $ " where the pwd is green, $ is yellow
# PROMPT="%{$fg_no_bold[green]%}%2~%{$reset_color%}%{$fg_no_bold[yellow]%}$%{$reset_color%} "

export NVM_DIR="~/.nvm/"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
