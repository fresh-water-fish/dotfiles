export LANG=en_GB.UTF-8
export TERM="xterm-256color"
export HISTORY_IGNORE="ls|cd"
export EDITOR="nvim"
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"

plugins=(git)

# Exit if not running interactively
[[ $- != *i* ]] && return

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

### CHANGE TITLE OF TERMINALS 
case ${TERM} in 
   xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
         ;;
   screen*)
     PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
     ;;
esac

colorscript random
eval "$(starship init zsh)"
