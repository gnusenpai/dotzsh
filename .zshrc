export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=32768
export SAVEHIST=$HISTSIZE

setopt appendhistory
setopt incappendhistory
setopt sharehistory

autoload -Uz compinit
compinit -C

zstyle ':completion:*' menu select

source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
