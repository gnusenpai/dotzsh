# Source custom configuration in login.d
for login in "$ZDOTDIR/login.d/"*.zsh(N); do
    source $login
done
