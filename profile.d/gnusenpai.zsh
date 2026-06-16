case ${PATH} in
    *${HOME}/bin*) ;;
    *) PATH=${HOME}/bin:${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH};;
esac

if [ -n "$INSIDE_EMACS" ]; then
    export EDITOR=emacsclient
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR
export PAGER=less

if command -v gpgconf >/dev/null; then
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    export SSH_AUTH_SOCK
fi
export FZF_DEFAULT_OPTS="--layout=reverse --height=33% --color=16"
export WINEDLLOVERRIDES=winemenubuilder.exe=d

if [ "$HOST" = djentoo ] && [ "$(tty)" = "/dev/tty2" ]; then
    if [ -s "${HOME}/.session" ]; then
        case $(<"${HOME}/.session") in
            x11)
                export SXHKD_SHELL=dash
                exec sx
                ;;
            gnome)
                export XDG_SESSION_TYPE=wayland
                exec gnome-session
                ;;
            hyprland)
                exec dbus-run-session Hyprland
                ;;
        esac
    fi
fi
