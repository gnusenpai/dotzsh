export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=32768
export SAVEHIST=$HISTSIZE

setopt appendhistory
setopt incappendhistory
setopt sharehistory

autoload -Uz compinit
compinit -C

zstyle ':completion:*' menu select
