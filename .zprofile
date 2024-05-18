source "${ZDOTDIR}/.zshenv"

# Source custom configuration in profile.d
for profile in "$ZDOTDIR/profile.d/"*.zsh(N); do
    source $profile
done
