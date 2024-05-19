if command -v gpgconf >/dev/null; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
export FZF_DEFAULT_OPTS="--layout=reverse --height=33% --color=16"
export WINEDLLOVERRIDES=winemenubuilder.exe=d

typeset -U path
path=("$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" $path)
