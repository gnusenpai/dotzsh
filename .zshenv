export ZDOTDIR=$HOME/.zsh
export EDITOR=nvim
export PAGER=most
export QT_QPA_PLATFORMTHEME=gtk2
path+=("$HOME/bin")

typeset -U path
path=($HOME/bin $path)
