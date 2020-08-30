export ZDOTDIR=$HOME/.zsh
export EDITOR=nvim
export PAGER=less
export SXHKD_SHELL=dash
export QT_QPA_PLATFORMTHEME=gtk2

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ANDROID_SDK_HOME=$XDG_CONFIG_HOME/android
export ATOM_HOME=$XDG_DATA_HOME/atom
export CARGO_HOME=$XDG_DATA_HOME/cargo
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.conf
export CCACHE_DIR=$XDG_CACHE_HOME/ccache
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export WGETRC=$XDG_CONFIG_HOME/wgetrc

typeset -U path
path=($HOME/bin $CARGO_HOME/bin $HOME/.local/bin $path)
