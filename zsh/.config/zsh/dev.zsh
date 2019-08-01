export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.rbenv/bin:$HOME/.tfenv/bin:$HOME/.local/bin:$PYENV_ROOT/bin:$PATH"

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


#######
# NVM #
#######

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

# AWS ZSH completer
[[ -s aws_zsh_completer.zsh ]] && source aws_zsh_completer.zsh

# AWS Profile/auth/MFA functions
[[ -s $HOME/.aws/aws_functions.zsh ]] && source $HOME/.aws/aws_functions.zsh

# Git loves fzf
[[ -s $ZSH_CONFIG/fzf-git.zsh ]] && source $ZSH_CONFIG/fzf-git.zsh

