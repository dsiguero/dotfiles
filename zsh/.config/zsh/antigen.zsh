# Antigen configuration

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-completions						# Aditional completion definitions for zsh.

antigen bundle zsh-users/zsh-syntax-highlighting				# This package provides syntax highlighting (whilst typing) for the shell zsh.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor pattern line root)

antigen bundle zsh-users/zsh-autosuggestions					# Suggests commands as you type based on history and completions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00617a,bold"				# For solarized dark theme

antigen bundle sudo												# Prefix current or previous command with sudo by pressing ESC twice.

antigen bundle ssh-agent
antigen bundle MenkeTechnologies/zsh-very-colorful-manuals		# Coloured man pages
antigen bundle jocelynmallon/zshmarks							# Simple CLI bookmarking plugin: `bookmark 'n`.
																# 	bookmark '<myname>': creates a new bookmark.
																#	jump '<myname>': cd to the given bookmark directory.

# Theme and customizations
antigen bundle yardnsm/blox-zsh-theme							
BLOX_CONF__ONELINE=true
BLOX_SEG__UPPER_LEFT=(host cwd git exec_time symbol)

antigen apply
