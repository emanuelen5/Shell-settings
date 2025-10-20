# Nice commands
alias where='echo -e "\b\r\e[K$YELLOW$USER$RED@$GREEN$HOSTNAME:$BLUE$PWD$NC "'
alias clc='reset;clear;clear;'
alias pd='pushd'
alias upd='popd 2>/dev/null'

alias grep='grep --color'
alias ls='ls --color'
alias trim-trailing-spaces="sed -i 's/[[:space:]]*\$//'"

alias venv='source venv/bin/activate'

# SSH agent commands
alias start-ssh-agent=". ~/bin/restore-ssh-agent.$host.sh"
alias ssh-add-keys="ssh-add-keys.$host "
function sshag() {
    start-ssh-agent
    ssh-add-keys
}

function mkcd () {
  if [ $# -lt 1 ]; then
    return
  fi
  mkdir "$@"
  cd "${@: -1}"
}
