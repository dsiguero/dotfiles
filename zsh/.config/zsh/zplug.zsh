# Antigen configuration

zplug "zsh-users/zsh-completions"						# Aditional completion definitions for zsh.
zplug "zsh-users/zsh-autosuggestions"					# Suggests commands as you type based on history and completions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00617a,bold"		# For solarized dark theme

zplug "plugins/sudo", from:oh-my-zsh					# Prefix current or previous command with sudo by pressing ESC twice.
zplug "plugins/ssh-agent", from:oh-my-zsh

zplug "MenkeTechnologies/zsh-very-colorful-manuals"		# Coloured man pages
zplug "jocelynmallon/zshmarks"							# Simple CLI bookmarking plugin: `bookmark 'n`.
																# 	bookmark '<myname>': creates a new bookmark.
																#	jump '<myname>': cd to the given bookmark directory.

# Theme and customizations
# zplug "yardnsm/blox-zsh-theme", as:theme
zplug romkatv/powerlevel10k, as:theme, depth:1

zplug "plugins/gitfast", from:oh-my-zsh, if:"[[ "${DEV_TOOLS}" == true ]]"
zplug "plugins/git-extras", from:oh-my-zsh, if:"[[ "${DEV_TOOLS}" == true ]]"
zplug "plugins/git-flow", from:oh-my-zsh, if:"[[ "${DEV_TOOLS}" == true ]]"
zplug "plugins/unixorn/git-extra-commands", from:oh-my-zsh, if:"[[ "${DEV_TOOLS}" == true ]]"

zplug "plugins/node", from:oh-my-zsh, if:"[[ "${DEV_MODE_NODE}" == true ]]"
zplug "plugins/npm", from:oh-my-zsh, if:"[[ "${DEV_MODE_NODE}" == true ]]"


# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

