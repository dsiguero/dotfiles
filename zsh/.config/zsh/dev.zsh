if [[ "${DEV_MODE_PYTHON}" == true ]]; then
    # pyenv
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
	    eval "$(pyenv virtualenv-init -)"
    fi

    # Add more python related stuff here.
fi

## TODO: Replace for fnm
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

# helm autocompletion
if command -v helm 1>/dev/null 2>&1; then
    source <(helm completion zsh)
fi

# Java 11 (openjdk)
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# The next line enables shell command completion for gcloud.
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
    source $HOME/google-cloud-sdk/completion.zsh.inc;
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
    source $HOME/google-cloud-sdk/path.zsh.inc;
fi

function gh_web {
  open $(git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@') | head -n1
}

alias base64=gbase64
alias xargs=gxargs
alias kctl=kubectl

wkctl() {
  watch kubectl $@
}

function ns_get_resources {
  kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $@
}

function have_you_tried {
  deployment_name="${1}"
  kubectl scale deployment "${deployment_name}" --replicas=0;
  sleep 5;
  kubectl scale deployment "${deployment_name}" --replicas=1;
}

function gcpsm_get {
  project=$1
  version="latest"

  if [[ $# -ne 1  ]]; then
    echo "Illegal number of parameters. Missing GCP project." >&2
    return 2
  fi

  secret_name=$(gcloud secrets list --project="${project}" | fzf --header-lines=1 | awk '{ print $1 }')
  gcloud secrets versions access latest --secret="${secret_name}" --project="${project}"
}

source $XDG_CONFIG/zsh/flexys.zsh