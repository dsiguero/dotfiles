# Antigen configuration

if [[ -s $ANTIGEN ]]; then
	source $ANTIGEN

	antigen use oh-my-zsh

	antigen bundle gitfast
	antigen bundle git-extras
	antigen bundle git-flow
	antigen bundle common-aliases
	antigen bundle sudo
	antigen bundle node
	antigen bundle npm
	antigen bundle aws
	antigen bundle dirhistory
	antigen bundle ssh-agent
	antigen bundle psprint/history-search-multi-word
	antigen bundle unixorn/git-extra-commands
	antigen bundle jocelynmallon/zshmarks
	antigen bundle MichaelAquilina/zsh-you-should-use
	antigen bundle zsh-users/zsh-syntax-highlighting

	antigen bundle mafredri/zsh-async
	antigen bundle sindresorhus/pure

	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor pattern line root)

	antigen apply
fi