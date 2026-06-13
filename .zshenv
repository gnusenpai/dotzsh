export ZDOTDIR=$HOME/.zsh

# Source custom configuration in env.d
for env in "$ZDOTDIR/env.d/"*.zsh(N); do
    source $env
done
