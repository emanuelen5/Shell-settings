# Nice commands
alias where='echo -e "\b\r\e[K$YELLOW$USER$RED@$GREEN$HOSTNAME:$BLUE$PWD$NC "'
alias clc='reset;clear;clear;'
alias pd='pushd'
alias upd='popd 2>/dev/null'

alias grep='grep --color'
alias ls='ls --color'
alias trim-trailing-spaces="sed -i 's/[[:space:]]*\$//'"

alias venv='source venv/bin/activate'
alias mkvenv='create_venv.sh'

# Linking scripts
alias start-ssh-agent=". ~/bin/ssh_agent_load.sh"
alias ssh-add-keys='cat ~/.ssh-keys.list | while read key; do ssh-add -l | grep -q $(ssh-keygen -lf $key  | awk "{print \$2}") || ssh-add $key; done'
alias sshag="start-ssh-agent "

