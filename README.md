# dotzsh
A minimal fish-inspired ZSH config without bloated plugin frameworks.

This is a draft, details will change.

## Installation
In your home directory:
```sh
git clone --recursive https://github.com/gnusenpai/dotzsh .zsh
ln -s .zsh/.zshenv .
exec zsh
zupdate
```

Optionally, delete my customizations if you want to bring your own:
```sh
rm ~/.zsh/*.d/gnusenpai.zsh
```

## Usage
This config utilizes ZSH's bytecompiling feature for faster startup.

Whenever you change your config, run:
```sh
zupdate
```

To remove all bytecompiled (`.zwc`) and temporary files (mainly for development):
```sh
zclean
```

## Customization
In general, you should not need to edit the `.z*` dotfiles directly. Just drop your customizations in the `env.d`, `profile.d`, `rc.d`, and `login.d` directories as `*.zsh` files. My personal customizations are included as examples.
