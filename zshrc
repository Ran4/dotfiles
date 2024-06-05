# TICK() { # Good for time testing
#     if [[ "$OSTYPE" == "darwin"* ]]; then
#         alias date=gdate
#     fi
#     echo A $@ $(date +%s.%N | tail -c +7)
# }

#ZSH related configuration {{{
# Source Prezto
[[ -f ~/.zprezto/init.zsh ]] && source ~/.zprezto/init.zsh
FPATH=~/.zsh/completion/:$FPATH

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd" # Command execution time stamp shown in the history command output.
HISTFILE=~/.zsh_history
HISTSIZE=400000
HISTFILESIZE=8000000
SAVEHIST=400000
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt SHARE_HISTORY

#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

# plugins loaded from ~/.oh-my-zsh/plugins/*, custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode docker docker-compose)

source ~/.zsh/exports.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/npm_completion.zsh
emulate sh -c "source /etc/profile"

#Don't autocomplete hosts. Inspiration: https://tlvince.com/fixing-slow-zsh-command-completion
zstyle ':completion:*' hosts off
# Ignore casing when using autocomplete 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -U compinit && compinit
source ~/.zsh/setopt.zsh
#End of ZSH related configuration }}}
#Keyboard related {{{
# source $ZSH/oh-my-zsh.sh
bindkey '^r' history-incremental-search-backward

#^p/^n or up/down will search previous line based on what's written,
#e.g. 'vim^p' -> 'vim file.py'
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
autoload -Uz edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line
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
bindkey -M vicmd q edit-command-line

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
if [ ! -f /.identifiers/mac ]; then
    set r rate 200 70
    if command_exists xset ; then
        # echo -n "(commandexists done, xset begin)"
        xset r rate 200 70 &> /dev/null ;
        # echo -n "(xset end)"
    fi
fi

autoload -Uz promptinit
promptinit

PROMPT="%B%~%b%F{green}$%f "

if [ ! -f /tmp/xkbmap_is_checked ]; then
    # touch /tmp/xkbmap_is_checked
    if command_exists setxkbmap ; then
        if [ -n "$DISPLAY" ]; then
            echo "7"
            if [ -f "/etc/arch-release" ]; then
                setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"
            else
                # REGULAR KEYBOARD:
                # setxkbmap -model pc105 -layout "se" -variant "nodeadkeys" -option "compose:rwin"

                # Swaps left alt and win key on mac keyboards.  The lv3:rwin_switch makes rcmd+¨ perform ~ (as opposed to option+¨)
                echo "7b"
                setxkbmap -option altwin:swap_lalt_lwin -variant "nodeadkeys" -layout "se" -option lv3:rwin_switch
                echo "7c"
            fi
            touch /tmp/xkbmap_is_checked
        fi
    fi
fi
# We need to run this every time we re-connect a keyboard... TODO: Fix this!
alias rmx="rm /tmp/xkbmap_is_checked"


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

#open pdf by simply typing it's name. -s is explained here: http://zshwiki.org/home/examples/aliassuffix
alias -s pdf=open

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
#01 bold, 35 magenta
export LESS_TERMCAP_md=$'\E[01;35m'      # begin bold: color for NAME, SYNOPSIS, DESCRIPTION...
export LESS_TERMCAP_me=$'\E[0m'          # end mode
#04 underline, 92 light green
#45 bg=magenta
export LESS_TERMCAP_so=$'\E[04;45m'   # begin standout-mode - Search highlighting
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode

#}}}}}}
source ~/.zsh/computer_specific_configs.zsh

# See http://situmam.blogspot.se/2012/05/emacs-keybidings-in-ubuntu-1204-precise.html
#gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/usr/local/share/dotnet"

# Always the set the volume to 58%
# [ -f ~/.identifiers/ran-main ] && amixer sset -q Master 50 2>&1 /dev/null
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
# source <(kubectl completion zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ran/other/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ran/other/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ran/other/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ran/other/google-cloud-sdk/completion.zsh.inc'; fi

if [ -x /opt/homebrew/opt/postgresql@11 ]; then
    export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"
fi
