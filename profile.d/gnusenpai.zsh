case ${PATH} in
    *${HOME}/bin*) ;;
    *) PATH=${HOME}/bin:${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH};;
esac

export XCURSOR_PATH=${HOME}/.local/share/icons:${XCURSOR_PATH}

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


# cleanup list-type environment vars
# e.g. PATH, XDG_DATA_DIRS, etc.
function clean_list() {
    eval 'local list=${'"${1}"'}:'
    local dir new_list

    while [ "${list}" ]; do
        dir=${list%%:*}
        list=${list#*:}

        # skip empty/non-existant
        [ -d "${dir}" ] || continue

        # skip duplicates
        case :${new_list}: in *:${dir}:*) continue;; esac

        new_list=${new_list}:${dir}
    done

    printf '%s' "${new_list#:}"
}

function liststoclean() {
    local line var
    env | while read -r line; do
        var=${line%%=*}
        case ${var} in
            *PATH|*DIRS) echo "${var}";;
        esac
    done
}

for list in $(liststoclean); do
    if eval '[ "${'"${list}"'}" ]'; then
        cleaned=$(clean_list "${list}")
        if [ "${cleaned}" ]; then
            eval "${list}"'=${cleaned}'
        else
            unset "${list}"
        fi
    fi

    unset cleaned
done

unset list
unset -f clean_list liststoclean


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
