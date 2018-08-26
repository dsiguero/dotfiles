# ZSH autocompletion config
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/siwi/.zshrc'

autoload -Uz compinit
compinit

xhost +local:root > /dev/null 2>&1

# Environment variables #

ZDOTDIR=$HOME
XDG_CONFIG=$HOME/.config

EDITOR=nano

HISTFILE=$HOME/.zsh_histfile
HISTSIZE=1000
SAVEHIST=1000

ZSH_CONFIG=$XDG_CONFIG/zsh

setopt appendhistory extendedglob
bindkey -e

export BROWSER=chromium
export ANTIGEN=/usr/share/zsh/share/antigen.zsh

# Aliases #

[[ -s $ZSH_CONFIG/aliases.zsh ]] && source $ZSH_CONFIG/aliases.zsh

# Antigen configuration #
[[ -s $ZSH_CONFIG/antigen.zsh ]] && source $ZSH_CONFIG/antigen.zsh

# Command not found hook # 
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Dev tooling config #
[[ -s $ZSH_CONFIG/dev.zsh ]] && source $ZSH_CONFIG/dev.zsh
