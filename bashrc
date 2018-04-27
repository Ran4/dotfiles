# vim: colorcolumn=80
#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

#Keyrate delay: msDelay (higher=longer delay), rate (quicker=faster)
set r rate 230 70
xset r rate 230 70 &> /dev/null ;

# Increase touchpad scroll speed on devices with the Synaptics input driver
if command_exists synclient ; then
    #default value is 111, at least on the HP Mini 110
    synclient VertScrollDelta=200 &> /dev/null ;
fi

#Set vim mode for bash
set editing-mode vi
set -o vi
set keymap vi-command

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

shopt -s histappend # append to the history file, don't overwrite it

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000000
HISTFILESIZE=8000000

shopt -s checkwinsize # check the window size after each command and, if
                      # necessary, update the values of LINES and COLUMNS.

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

alias ls='ls -hF' #human readable, append indicator (one of */=>@|)
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #if we can read the file ~/.dircolors, then eval list of colors given by $(dircolors -b ~/.dircolors)
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -hF' #color, human readable, append indicator (one of */=>@|)
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[ -f ~/.bash_setprompt ] && . ~/.bash_setprompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.hhighlighter.sh ]; then
    . ~/.hhighlighter.sh
fi

#run() {
#    ($@ &> /dev/null &)
#}

# Color for less
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.identifiers/ranlubuntu ]; then
    . ~/.custom/ranlubuntu_bash_setprompt
    alias m='/etc/init.d/ran_mount_vb.sh'
fi

[ -f ~/.identifiers/ranvb ] && . ~/.custom/ranvb_bash_setprompt
[ -f ~/.identifiers/ranmini ] && . ~/.custom/ranmini_bash_setprompt

if [ -f ~/.identifiers/ranl412 ]; then
    #Disable TouchPad:
    declare -i ID
    ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
    xinput set-prop $ID "Device Enabled" 0
    #echo 'Touchpad has been disabled.'
    
    #Increase speed of trackpoint. Default is 1.0, 0.8 is faster
    TRACKPOINT_NAME=$(xinput --list --name-only | g -i trackpoint)
    xinput --set-prop "$TRACKPOINT_NAME" "Device Accel Constant Deceleration" 0.8
fi

if [ -f ~/.identifiers/kth ]; then
    . ~/.custom/kth_bash_setprompt
    unlink ~/.tmux.conf
    ln -s ~/.custom/kth_tmux.conf ~/.tmux.conf
    
    #Change to zsh without root
    export SHELL=/bin/zsh
    exec /bin/zsh -l
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if command_exists xcape ; then
    . ~/.xcape_config
    #echo "Not running xcape config!"
else
    if [ ! -f "/etc/arch-release" ] ; then
        if [[ "$OSTYPE" =~ ^darwin ]]; then
            :
        else
            if command_exists xmodmap ; then
                xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
            fi
        fi
    fi
    #echo "Not running xmodmap!"
fi

if command_exists setxkbmap ; then
    if [ -f "/etc/arch-release" ]; then
        setxkbmap -model pc105 -layout "se" -variant "nodeadkeys"
    else
        setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin" -option ctrl:nocaps
    fi
fi
