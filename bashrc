#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

#msDelay (higher=longer), rate (quicker=faster)
set r rate 230 70
xset r rate 230 70 &> /dev/null ;

if command_exists synclient ; then
    #default value is 111, at least on the HP Mini 110
    synclient VertScrollDelta=200 &> /dev/null ;
fi

#prevent <c-s> from stopping the terminal #causes warning on boot? Hm?
#stty stop undef

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

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=8000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias ls='ls --color=auto -h'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


if [ -f ~/gitclones/z/z.sh ]; then
    . ~/gitclones/z/z.sh
fi

if [ -f ~/.bash_setprompt ]; then
    . ~/.bash_setprompt
fi


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

run() {
    ($@ &> /dev/null &)
}

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
fi

if [ -f ~/.identifiers/ranvb ]; then
    . ~/.custom/ranvb_bash_setprompt
fi

if [ -f ~/.identifiers/ranmini ]; then
    . ~/.custom/ranmini_bash_setprompt
fi

if [ -f ~/.identifiers/ranl412 ]; then
    . ~/.custom/ranl412_bash_setprompt
    unlink ~/.tmux.conf
    ln -s ~/.custom/ranl412_tmux.conf ~/.tmux.conf
    
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
    #cp ~/.custom/kth_tmux.conf ~/.tmux.conf
    unlink ~/.tmux.conf
    ln -s ~/.custom/kth_tmux.conf ~/.tmux.conf
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#xmodmap ~/.xmodmap_swap_caps_and_ctrl &> /dev/null &
#sleep to avoid the "please release the following keys within 2 seconds" thing
#sleep 0.2 && xmodmap ~/.xmodmap_swap_caps_and_ctrl
xmodmap ~/.xmodmap_swap_caps_and_ctrl &> /dev/null
#if command_exists xcape ; then
#    #. ~/.xcape_config
#    echo "Not running xcape config!"
#else
#    #xmodmap ~/.xmodmap_swap_caps_and_ctrl &> /dev/null ;
#    echo "Not running xmodmap!"
#fi

