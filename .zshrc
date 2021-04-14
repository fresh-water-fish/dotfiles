export LANG=en_GB.UTF-8
export TERM="xterm-256color"
export HISTORY_IGNORE="ls|cd"
export EDITOR="vim"
export ZSH=$HOME/.oh-my-zsh
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Exit if not running interactively
[[ $- != *i* ]] && return

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
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

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

colorscript random

# Uncomment to use powerlevel10k / starship
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(starship init zsh)"
