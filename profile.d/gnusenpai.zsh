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
