# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -f "$XDG_CONFIG_HOME/wpg/sequences" ] && (cat $XDG_CONFIG_HOME/wpg/sequences &)

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=32768
export SAVEHIST=$HISTSIZE

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export ZLE_REMOVE_SUFFIX_CHARS=""

setopt appendhistory
setopt histignorealldups
setopt histignorespace
setopt incappendhistory
setopt sharehistory
setopt autocd

autoload -Uz compinit
compinit -C

zstyle ':completion:*' menu select

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source $ZDOTDIR/prompts/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

alias e='$EDITOR'
alias ls='exa'
alias la='ls -lab'
alias grep='grep --color=auto'
alias qr='qrencode -t utf8'
alias xin='xclip -sel c'
alias xout='xclip -sel c -o'

function fe {
    rg -uu --files $1 2> /dev/null |
    sed '/.git\//d' |
    fzf --layout=reverse --height=33% --color=16 |
    xargs -r $EDITOR
}

function se {
    rg -uu --files ~/bin ~/.config ~/.zsh 2> /dev/null |
    sed 's|/home/josh|~|' |
    fzf --layout=reverse --height=33% --color=16 |
    sed 's|~|/home/josh|' |
    xargs -r $EDITOR
}

function fd {
    dir=$(find $1 -type d -print 2> /dev/null |
        sed 's|^./||; /.git/d' |
        fzf --layout=reverse --height=50% --color=16) &&
    pushd "$dir"
}

function zupdate {
    compinit
    find $ZDOTDIR -type f -name "*.zsh" | xargs -r -I '%' zsh -c 'zcompile %'
    for f in .zcompdump .zprofile .zshenv .zshrc; do
        zcompile $ZDOTDIR/$f
    done
}

bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' delete-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
