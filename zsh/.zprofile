# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
fi

export XDG_DATA_HOME="${XDG_DATA_HOME:=${HOME}/.local/share}"
