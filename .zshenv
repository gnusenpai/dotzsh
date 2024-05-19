export ZDOTDIR=$HOME/.zsh

if [ -n "$INSIDE_EMACS" ]; then
    export EDITOR=emacsclient
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR
export PAGER=less

# Source custom configuration in env.d
for env in "$ZDOTDIR/env.d/"*.zsh(N); do
    source $env
done
