# Aliases

alias cp='cp -i'
alias df='df -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '


# In MacOS ls syntax is different, not having the --color flag
if ! [[ "$OSTYPE" =~ ^darwin ]]; then
  alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %J:%M" --color=auto -F'
  alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %J:%M" --color=auto -F'
  alias ls='ls --color=auto'
fi

# Arch Linux specific aliases
if [ -f "/etc/arch-release" ]; then
  alias update='yay -Syua'
fi

alias more=less
alias tf=terraform
alias tfa='terraform apply'
alias tfp='terraform plan -out=plan.tfplan'
alias tfd='terraform destroy'
alias 2fa='ykman oath code $(ykman oath list | fzf)'  # Easy CLI MFA with Yubikey Manager and fzf

# Git aliases
alias diff="git diff | ydiff -s"
