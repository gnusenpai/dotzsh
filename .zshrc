# This absolutely has to be at the top...
export GPG_TTY=$(tty)

# History settings
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=1048576
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt histignorealldups
setopt histignorespace
setopt incappendhistory
setopt sharehistory

# Misc ZSH settings
WORDCHARS=${WORDCHARS/\/}
ZLE_REMOVE_SUFFIX_CHARS=""
REPORTTIME=1

setopt autocd

# Completion
autoload -Uz compinit bashcompinit
compinit
bashcompinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:default' list-colors ''

# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/F-Sy-H/F-Sy-H.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

# grc (Generic Colouriser) integration
for i in "/etc/grc.zsh" "/usr/share/grc/grc.zsh"; do
    if [ -f $i ]; then
        source $i
        unset -f make
        break
    fi
done

# Prompt customization
function precmd() {
    # shellcheck disable=SC2317
    function precmd() {
        # This fixes the cursor after using programs like vim in normal terminals
        if [ -z "$INSIDE_EMACS" ]; then
            printf '\e[5 q'
        fi
        echo
    }
}

if [ -f "${ZDOTDIR}/hostname" ]; then
    _hostname="$(<"${ZDOTDIR}/hostname")"
else
    _hostname='%m'
fi

if command -v ip >/dev/null && ! ip 2>&1 | grep BusyBox >/dev/null; then
    _netns=$(ip netns identify)
    if [ -n "$_netns" ]; then
        _netns="in $_netns "
    fi
fi

# username@hostname
PROMPT="%n@${_hostname} "
# extra status
PROMPT="${PROMPT}${_netns}"
# current directory
PROMPT="${PROMPT}"'%F{4}%~%f'
# exit code (only show when non-zero)
PROMPT="${PROMPT}"'%(?.. %F{1}%?%f)'
# newline
PROMPT="${PROMPT}"$'\n'
# set prompt char color based on exit code
PROMPT="${PROMPT}"'%(?.%F{2}.%F{1})'
# prompt char (# on root, > on non-root)
PROMPT="${PROMPT}"'%(!.#.>)%f '

if [ "$INSIDE_EMACS" = "vterm" ]; then
    source "$ZDOTDIR/plugins/vterm.zsh"
fi

# Global aliases
alias la='ls -la'
alias grep='grep --color=auto'

# ZSH Housekeeping
function zclean() {
    if [ -d "${ZDOTDIR}" ]; then
        echo "Removing:"
        pushd "${ZDOTDIR}" >/dev/null
        find . -type f -name "*.zwc" -delete -print | sed 's|^\./| |'
        popd >/dev/null
    else
        echo "Something went really wrong!"
        echo "Aborting to protect your files."
        return 1
    fi
}

function zupdate() {
    if [ -d "${ZDOTDIR}" ]; then
        compinit
        bashcompinit

        echo "Compiling:"
        pushd "${ZDOTDIR}" >/dev/null
        for file in .zshenv .zprofile .zshrc .zlogin .zcompdump \
            $(find . -type f -name "*.zsh" -print | sed 's|^\./||')
        do
            echo " ${file}"
            zcompile "${ZDOTDIR}/${file}"
        done
        popd >/dev/null

        zsh -i -c builtin exit
    else
        echo "Something went really wrong!"
        echo "Aborting to protect your files."
        return 1
    fi
}

# Keybinds
bindkey -e
bindkey '^H'      backward-kill-word            # Ctrl+Backspace
bindkey '^[[H'    beginning-of-line             # Home
bindkey '^[[F'    end-of-line                   # End
bindkey '^[[1~'   beginning-of-line             # TTY Home
bindkey '^[[4~'   end-of-line                   # TTY End
bindkey '^[[3~'   delete-char                   # Delete
bindkey '^[[3;5~' delete-word                   # Ctrl+Delete
bindkey '^[[1;5D' backward-word                 # Ctrl+Left
bindkey '^[[1;5C' forward-word                  # Ctrl+Right
bindkey '^[[A'    history-substring-search-up   # Up
bindkey '^[[B'    history-substring-search-down # Down

# Source custom configuration in rc.d
for rc in "$ZDOTDIR/rc.d/"*.zsh(N); do
    source $rc
done
