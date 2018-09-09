#######################################################
### FZF is awesome: https://github.com/junegunn/fzf ###
#######################################################

# https://unix.stackexchange.com/questions/403916/getting-started-with-fzf-on-arch-linux

# Loading ZSH autocompletion **<TAB>
[[ -s /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# Using fd by default (find replacment)
export FZF_DEFAULT_COMMAND='fd --type f'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
# fo() {
#   local out file key
#   IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
#   key=$(head -1 <<< "$out")
#   file=$(head -2 <<< "$out" | tail -1)
#   if [ -n "$file" ]; then
#     [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
#   fi
# }


### PATH
# mnemonic: [F]ind [P]ath
# list directories in $PATH, press [enter] on an entry to list the executables inside.
# press [escape] to go back to directory listing, [escape] twice to exit completely
fp () {
	local loc=$(echo $PATH | sed -e $'s/:/\\\n/g' | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

	if [[ -d $loc ]]; then
	  echo "$(rg --files $loc | rev | cut -d"/" -f1 | rev)" | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' >/dev/null"
	  fp
	fi
}

# fd - cd into the selected directory including hidden directories
icd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
icdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# # fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}