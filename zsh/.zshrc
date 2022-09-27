# ## Enable for profiling
# # zmodload zsh/zprof

ZDOTDIR=$HOME
XDG_CONFIG=$HOME/.config
EDITOR=nvim
ZSH_CONFIG=$XDG_CONFIG/zsh

setopt EXTENDED_GLOB          # Treat `#`, `~`, and `^` as patterns for filename globbing.

setopt AUTO_CD                  # Perform cd to a directory if the typed command is invalid, but is a directory.
setopt AUTO_PUSHD               # Make cd push the old directory to the directory stack.
setopt PUSHD_IGNORE_DUPS        # Don't push multiple copies of the same directory to the stack.
setopt PUSHD_SILENT             # Don't print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME            # Have pushd without arguments act like `pushd ${HOME}`.

setopt extendedhistory					# Save command's beginning timestamp and duration in the history file.
setopt appendhistory 					  # Append history to history file (no overwriting).
setopt sharehistory						  # Share history across terminals.
setopt incappendhistory					# Immediately append to the history file, not just when a terminal is stopped.
setopt hist_ignore_dups     		# ignore duplicated commands history list
setopt hist_find_no_dups				# ignore duplicates when searching (Ctrl + R)
setopt hist_expire_dups_first 	# delete duplicates first when history exceeds HISTSIZE
setopt hist_save_no_dups				# ignore duplicates when writing history file
setopt hist_verify          		# show command with history expansion to user before running it

# The maximum number of events stored internally and saved in the history file.
# The former is greater than the latter in case user wants HIST_EXPIRE_DUPS_FIRST.
HISTSIZE=20000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_histfile

# Slash and hyphen are word separators
WORDCHARS=${WORDCHARS//[\/]}
WORDCHARS=${WORDCHARS//-}

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00617a,bold"				# For solarized dark theme

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor pattern line root)


# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

# if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
#   # Download zimfw script if missing.
#   command mkdir -p ${ZIM_HOME}
#   if (( ${+commands[curl]} )); then
#     command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
#   else
#     command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
#   fi
# fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# # Bind up and down keys
# zmodload -F zsh/terminfo +p:terminfo
# if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
#   bindkey ${terminfo[kcuu1]} history-substring-search-up
#   bindkey ${terminfo[kcud1]} history-substring-search-down
# fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install






# # ZSH autocompletion config
# zstyle ':completion:*' completer _complete _ignored
# # zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# # zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
# zstyle :compinstall filename '$HOME/.zshrc'
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# # Add brew's autocompletion functions to FPATH
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

# autoload -Uz compinit
# if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
# 	compinit
# else
# 	compinit -C
# fi

export CLICOLOR=1			# Use colored output for ls and other commands

# Aliases #
[[ -s $ZSH_CONFIG/aliases.zsh ]] && source $ZSH_CONFIG/aliases.zsh

export BAT_THEME="Solarized (dark)"

# fzf functions #
FZF_CONFIG="${XDG_CONFIG}/fzf"
if command -v fzf >/dev/null 2>&1; then
	for f in "${FZF_CONFIG}"/*.zsh; do source $f; done
fi

# Dev stuff #
DEV_TOOLS=true
DEV_MODE_PYTHON=true
[[ "${DEV_TOOLS}" == "true" ]] && [[ -s $ZSH_CONFIG/dev.zsh ]] && source $ZSH_CONFIG/dev.zsh

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

export LSCOLORS=GxFxCxDxBxegedabagaced


# ## Enable for profiling
# #zprof
