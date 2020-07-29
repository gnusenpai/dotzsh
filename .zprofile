HOST=$(hostname)

if [ "$HOST" = arch ]; then
    if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        if lspci -nk | grep "Kernel driver in use: nvidia" > /dev/null; then
            exec startx -- -config xorg.nvidia.conf
        else
            exec startx
        fi
    fi
fi

if [ "$HOST" = djentoo ]; then
    source $ZDOTDIR/.zshenv
    if [ "$(tty)" = "/dev/tty1" ]; then
        exec startx -- vt1
    fi
fi
