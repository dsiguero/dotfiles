if [[ "${DEV_MODE_PYTHON}" == true ]]; then
    # pyenv
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
	    eval "$(pyenv virtualenv-init -)"
    fi

    # Add more python related stuff here.
fi

if [[ "${DEV_MODE_NODE}" == true ]]; then
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

    # Add more node related stuff here.
fi

# AWS Profile/auth/MFA functions
[[ -s $HOME/.aws/aws_functions.zsh ]] && source $HOME/.aws/aws_functions.zsh

# kubectl autocompletion
if command -v kubectl 1>/dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

# Java 11 (openjdk)
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# Antigen plugins for development
if command -v antigen >/dev/null 2>&1; then
    antigen bundle gitfast
    antigen bundle git-extras
    antigen bundle git-flow
    antigen bundle unixorn/git-extra-commands

    [[ "${DEV_MODE_NODE}" == true ]] && antigen bundle node
    [[ "${DEV_MODE_NODE}" == true ]] && antigen bundle npm
    
    antigen apply
fi
