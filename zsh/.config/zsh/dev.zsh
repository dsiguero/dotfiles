export PATH="$HOME/.rbenv/bin:$HOME/.tfenv/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Git loves fzf
[[ -s $ZSH_CONFIG/fzf-git.zsh ]] && source $ZSH_CONFIG/fzf-git.zsh

alias diff="git diff | ydiff -s"

# SDKMAN
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/siwi/.sdkman"
[[ -s "/home/siwi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/siwi/.sdkman/bin/sdkman-init.sh"

eval "$(rbenv init -)"
