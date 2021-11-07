# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Enable for profiling
# zmodload zsh/zprof

# ZSH autocompletion config
zstyle ':completion:*' completer _complete _ignored
# zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Add brew's autocompletion functions to FPATH
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
	compinit
else
	compinit -C
fi

## Environment variables
ZDOTDIR=$HOME
XDG_CONFIG=$HOME/.config

## History
setopt extendedhistory					# Save command's beginning timestamp and duration in the history file.
setopt appendhistory 					# Append history to history file (no overwriting).
setopt sharehistory						# Share history across terminals.
setopt incappendhistory					# Immediately append to the history file, not just when a terminal is stopped.
setopt hist_ignore_dups     			# ignore duplicated commands history list
setopt hist_find_no_dups				# ignore duplicates when searching (Ctrl + R)
setopt hist_expire_dups_first 			# delete duplicates first when history exceeds HISTSIZE
setopt hist_save_no_dups				# ignore duplicates when writing history file
setopt hist_verify          			# show command with history expansion to user before running it
setopt globdots							# Matches dot-files (hidden) without explicitly specifying the dot.

HISTSIZE=5000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_histfile

ZSH_CONFIG=$XDG_CONFIG/zsh



# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search                                                
bindkey '^[[B' down-line-or-search

EDITOR=nvim

case "$OSTYPE" in
  darwin*)
	export BROWSER=open
	export ZPLUG=/usr/local/opt/zplug/init.zsh
	export PATH="/usr/local/sbin:$PATH:$HOME/.bin"
	;; 
  linux*)
	export BROWSER=chromium
	export TERMINAL=termite
	export PATH="$PATH:$HOME/.bin"
	;;
esac

# Aliases #
[[ -s $ZSH_CONFIG/aliases.zsh ]] && source $ZSH_CONFIG/aliases.zsh

# Dev stuff #
DEV_TOOLS=true
DEV_MODE_PYTHON=true
[[ "${DEV_TOOLS}" == "true" ]] && [[ -s $ZSH_CONFIG/dev.zsh ]] && source $ZSH_CONFIG/dev.zsh

export BAT_THEME="Solarized (dark)"

# fzf functions #
FZF_CONFIG="${XDG_CONFIG}/fzf"
if command -v fzf >/dev/null 2>&1; then
	for f in "${FZF_CONFIG}"/*.zsh; do source $f; done
fi

# ZPlug configuration #
[[ -s "${ZPLUG}" ]] && source "${ZPLUG}" && \
	[[ -s "${ZSH_CONFIG}/zplug.zsh" ]] && source "${ZSH_CONFIG}/zplug.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZSH_CONFIG/.p10k.zsh ]] || source $ZSH_CONFIG/.p10k.zsh

## Enable for profiling
#zprof

