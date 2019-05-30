## Enable for profiling
# zmodload zsh/zprof

# ZSH autocompletion config
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
	compinit
else
	compinit -C
fi

if ! [[ "$OSTYPE" =~ ^darwin ]]; then
	xhost +local:root > /dev/null 2>&1;
fi

# Environment variables #

ZDOTDIR=$HOME
XDG_CONFIG=$HOME/.config

HISTFILE=$HOME/.zsh_histfile
HISTSIZE=1000
SAVEHIST=1000

ZSH_CONFIG=$XDG_CONFIG/zsh

setopt appendhistory extendedglob
bindkey -e

case "$OSTYPE" in
  darwin*)
	export ANTIGEN=/usr/local/share/antigen/antigen.zsh
	export PATH="/usr/local/sbin:$PATH"
	;; 
  linux*)
	EDITOR=nano
	export BROWSER=chromium
	export TERMINAL=termite
	export ANTIGEN=/usr/share/zsh/share/antigen.zsh
	export PATH="$PATH:$HOME/.bin"
	;;
esac


# Aliases #

[[ -s $ZSH_CONFIG/aliases.zsh ]] && source $ZSH_CONFIG/aliases.zsh

# Antigen configuration #
[[ -s $ZSH_CONFIG/antigen.zsh ]] && source $ZSH_CONFIG/antigen.zsh

# Command not found hook # 
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Dev stuff #
[[ -s $ZSH_CONFIG/dev.zsh ]] && source $ZSH_CONFIG/dev.zsh

# FZF general functions #
[[ -s $ZSH_CONFIG/fzf.zsh ]] && source $ZSH_CONFIG/fzf.zsh

# Marker (command bookmark: https://github.com/pindexis/marker)
# [[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"


if ! [[ "$OSTYPE" =~ ^darwin ]]; then
	# Can use fd as a 'find' alias because it's not a command in OS X
	unalias fd;
fi

## Enable for profiling
# zprof