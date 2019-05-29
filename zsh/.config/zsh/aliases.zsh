# Aliases

alias cp='cp -i'
alias df='df -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# In MacOS ls syntax is differnt, not having the --color flag
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

# WIN 10 QEMU/KVM virtualisation
if command -v virsh --version 1>/dev/null 2>&1; then
  function win10() {
    vm_name=win10

    case "$1" in
      'start')
        echo "Starting Win 10 VM"
        sudo virsh start $vm_name
      ;;
      'stop')
        echo "Shutting down Win 10 VM"
        sudo virsh shutdown $vm_name
      ;;
      'save')
        echo "Saving Win 10 VM state..."
        sudo virsh dompmsuspend --domain $vm_name --target disk
      ;;
      *)
        echo "Usage: $0 [start|stop|save]"
      ;;
    esac
  }
fi

 