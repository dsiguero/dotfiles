# Aliases

alias cp='cp -i'
alias df='df -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %J:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %J:%M" --color=auto -F'
alias ls='ls --color=auto'
alias update='yay -Syua'
alias more=less
alias tf=terraform
alias tfa='terraform apply'
alias tfp='terraform plan -out=plan.tfplan'
alias tfd='terraform destroy'
alias 2fa='ykman oath code $(ykman oath list | fzf)'