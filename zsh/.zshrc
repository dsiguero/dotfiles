## Enable for profiling
# zmodload zsh/zprof

# ZSH autocompletion config
zstyle ':completion:*' completer _complete _ignored
# zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
zstyle :compinstall filename '$HOME/.zshrc'

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

HISTSIZE=5000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_histfile

ZSH_CONFIG=$XDG_CONFIG/zsh

setopt globdots				# Matches dot-files (hidden) without explicitly specifying the dot.

EDITOR=vim

case "$OSTYPE" in
  darwin*)
	export BROWSER=open
	export ANTIGEN=/usr/local/share/antigen/antigen.zsh
	export PATH="/usr/local/sbin:$PATH:$HOME/.bin"
	;; 
  linux*)
	export BROWSER=chromium
	export TERMINAL=termite
	export ANTIGEN=/usr/share/zsh/share/antigen.zsh
	export PATH="$PATH:$HOME/.bin"
	;;
esac

# Aliases #
[[ -s $ZSH_CONFIG/aliases.zsh ]] && source $ZSH_CONFIG/aliases.zsh

# Antigen configuration #
[[ -s "${ANTIGEN}" ]] && source "${ANTIGEN}" && \
	[[ -s "${ZSH_CONFIG}/antigen.zsh" ]] && source "${ZSH_CONFIG}/antigen.zsh"

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

[[ -s /usr/local/etc/profile.d/z.sh ]] && source /usr/local/etc/profile.d/z.sh 


## Enable for profiling
#zprof

