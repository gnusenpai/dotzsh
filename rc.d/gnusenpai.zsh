alias e=$EDITOR
alias qr='qrencode -t utf8'

if command -v eza >/dev/null; then
    alias ls='eza'
    alias la='ls -lab'
    alias tree='ls -T'
fi

if command -v bat >/dev/null; then
    alias bat='bat --theme=base16 --paging=never'
    alias cat='bat'
fi

if command -v zoxide >/dev/null; then
    if ! [ -f "${ZDOTDIR}/plugins/zoxide.zsh" ]; then
        zoxide init --cmd cd zsh > "${ZDOTDIR}/plugins/zoxide.zsh"
        zcompile "${ZDOTDIR}/plugins/zoxide.zsh"
    fi
    source "${ZDOTDIR}/plugins/zoxide.zsh"
fi

if [ -n "$DISPLAY" ]; then
    alias xin='xclip -sel c'
    alias xout='xclip -sel c -o'
fi


function vfio_search() {
    grc --colour=on lspci -k | grep -v "Subsystem\|modules" | grep -i -A1 "$1"
}

function vfio_attach() {
    virsh nodedev-reattach --device pci_0000_"$(lspci | grep -i "$1" | cut -d' ' -f1 | sed -E 's/(:|\.)/_/g')"
}

function vfio_detach() {
    virsh nodedev-detach --device pci_0000_"$(lspci | grep -i "$1" | cut -d' ' -f1 | sed -E 's/(:|\.)/_/g')"
}

function vfio_list() {
    grc --colour=on lspci -k | grep -v "Subsystem\|modules" | grep -B1 vfio-pci
}

function mem() {
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}


unset '_comps[tol]'

function ct() {
    if [ -z "$1" ]; then
        cd "$(tol search)"
    else
        cd "$(tol $1)"
    fi
}


if command -v fzf >/dev/null; then
    function ze() {
        rg -uu --files "$1" 2> /dev/null |
        sed '/.git\//d' |
        fzf --layout=reverse --height=33% --color=16 |
        xargs -r "$EDITOR"
    }

    function se() {
        rg -uu --files ~/bin ~/.config ~/.zsh 2> /dev/null |
        sed 's|/home/josh|~|' |
        fzf --layout=reverse --height=33% --color=16 |
        sed 's|~|/home/josh|' |
        xargs -r "$EDITOR"
    }

    function zd() {
        dir=$(find "$1" -type d -print 2> /dev/null |
            sed 's|^./||; /.git/d' |
            fzf --layout=reverse --height=50% --color=16) &&
        pushd "$dir" || return 1
    }

    if [ -f "${ZDOTDIR}/plugins/fzf.zsh" ]; then
        export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 -path '*/.*' -prune -o -type d -print 2> /dev/null | cut -b3-"
        source "${ZDOTDIR}/plugins/fzf.zsh"
    fi
fi


if [ "$INSIDE_EMACS" = "vterm" ]; then
    unalias e
    function e() {
        vterm_cmd find-file "$(realpath "${@:-.}")"
    }

    function say() {
        vterm_cmd message "%s" "$*"
    }

    function exit() {
        (
            sleep 1
            kill -1 $$
        ) &
        vterm_cmd delete-frame
    }
fi
