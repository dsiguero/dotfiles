export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"


#########
# RBENV #
#########
if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init -)"
fi

#########
# PYENV #
#########
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

#########
# Conda #
#########
# export CONDA_PATH="/Users/dan/anaconda3/bin"


# export PATH="$HOME/.rbenv/bin:$HOME/.tfenv/bin:$HOME/.local/bin:$PYENV_ROOT/bin:$CONDA_PATH:$PATH"

##########
# Flyway #
##########
export PATH="$PATH:$HOME/Documents/development/nats/flyway-5.2.4"

#######
# NVM #
#######

# running nvm use if .nvmrc exists when accessing a directory
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
    NVM_DIRTY=true
  elif [[ $NVM_DIRTY = true ]]; then
    nvm use default
    NVM_DIRTY=false
  fi
}
add-zsh-hook chpwd load-nvmrc

# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .zshrc gets sourced multiple times
# by checking whether __init_nvm is a function.
# https://www.growingwiththeweb.com/2018/01/slow-nvm-init.html

# Originally using "$(type -t __init_nvm)" but zsh does not support -t

if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type __init_nvm | awk '{ print $5 }')" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  
  declare -a __node_commands=('nvm' 'node' 'npm' 'npx' 'yarn' 'webpack')

  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }

  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# AWS Profile/auth/MFA functions
[[ -s $HOME/.aws/aws_functions.zsh ]] && source $HOME/.aws/aws_functions.zsh

# AWS ZSH completer
[[ -s $ZSH_CONFIG/aws_zsh_completer.zsh ]] && source $ZSH_CONFIG/aws_zsh_completer.zsh

# Git loves fzf
[[ -s $ZSH_CONFIG/fzf-git.zsh ]] && source $ZSH_CONFIG/fzf-git.zsh

# Docker loves fzf
[[ -s $ZSH_CONFIG/fzf-docker.zsh ]] && source $ZSH_CONFIG/fzf-docker.zsh

# AWS default region
export AWS_DEFAULT_REGION=eu-west-1

# TF scaffold support for mac
export GNU_GETOPT="$(brew --prefix gnu-getopt)/bin/getopt"

# psql without postgres
export PATH="$PATH:$(brew --prefix libpq)/bin"