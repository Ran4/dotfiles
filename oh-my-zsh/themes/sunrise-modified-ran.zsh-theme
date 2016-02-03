# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: http://ethanschoonover.com/solarized
# (Needs Git plugin for current_branch method)

# Color shortcuts
RED=$fg_no_bold[red]
GREEN=$fg_no_bold[green]
MAGENTA=$fg_no_bold[magenta]
YELLOW=$fg_no_bold[yellow]
BLUE=$fg_no_bold[blue]
LIGHTBLUE=$fg_no_bold[yellow]
#Find more colors with $(spectrum_ls)
PURPLE_PINK=$FG[013]
RESET=$reset_color

if [ "$USER" = "root" ]; then
    PROMPTCOLOR="%{$RED%}" PREFIX="-!-";
else
    PROMPTCOLOR="" PREFIX="---";
fi

local return_code="%(?..%{$RED%}%? ↵%{$RESET%})"

# Get the status of the working tree (copied and modified from git.zsh)
custom_git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  # Non-staged
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^.M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  # Staged
  if $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^M' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_ADDED$STATUS"
  fi

  if $(echo -n "$STATUS" | grep '.*' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_STATUS_PREFIX$STATUS"
  fi

  echo $STATUS
}

# get the name of the branch we are on (copied and modified from git.zsh)
function custom_git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_ahead)$(custom_git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX "
}

# %B sets bold text
#PROMPT='%B %2~ $(custom_git_prompt)%{$MAGENTA%}%B»%b%{$RESET%} '
#PROMPT='%2~$(custom_git_prompt)%{$MAGENTA%}%B»%b%{$RESET%} '
#PROMPT='%2~$(custom_git_prompt)%{$LIGHTBLUE%}%B»%b%{$RESET%} '
#PROMPT='%12~$(custom_git_prompt)%{$LIGHTBLUE%}%B$%b%{$RESET%} '
PWD_COLOR=$FG[035] #green
PROMPT='%{$PWD_COLOR%}%12~$(custom_git_prompt)%{$LIGHTBLUE%}%B$%b%{$RESET%} '
RPS1="${return_code}"

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$YELOW%}‹"
#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$YELOW%}›"
#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$PURPLE_PINK%}›"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$PURPLE_PINK%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$YELOW%}›%{$RESET%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$RESET%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$BLUE%}➔"


#ZSH_THEME_GIT_STATUS_PREFIX=" "
ZSH_THEME_GIT_STATUS_PREFIX=""

# Staged
ZSH_THEME_GIT_PROMPT_STAGED_ADDED="%{$GREEN%}A"
ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED="%{$GREEN%}M"
ZSH_THEME_GIT_PROMPT_STAGED_RENAMED="%{$GREEN%}R"
ZSH_THEME_GIT_PROMPT_STAGED_DELETED="%{$GREEN%}D"

# Not-staged
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$RED%}?"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$RED%}M"
ZSH_THEME_GIT_PROMPT_DELETED="%{$RED%}D"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$RED%}UU"
