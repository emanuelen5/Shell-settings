[ -f /etc/skel/.bashrc ] && source /etc/skel/.bashrc
. ~/bin/bash_colors.sh

# Defaults
export EDITOR=$(which vim)
export VISUAL=$(which vim)
export umask=002
export PATH="$PATH:~/bin"

# Setting up a clean terminal
. ~/bin/PS1_setup.sh
. ~/bin/cd_enter_exit.sh

# Removing ^s as suspend terminal
stty -ixon

# Improving history
export HISTSIZE=10000
export HISTTIMEFORMAT="(%Y-%m-%d %T) "

# For stopping annoying loud bells
set bell-style visible

# Linking scripts
alias start-ssh-agent=". ~/bin/ssh_agent_load.sh"
alias ssh-add-keys='ssh-add $(cat ~/.ssh-keys.list 2>/dev/null) || ssh-add'
alias sshag="start-ssh-agent "
start-ssh-agent -r > /dev/null

# Nice commands
alias where='echo -e "\b\r\e[K$YELLOW$USER$RED@$GREEN$HOSTNAME:$BLUE$PWD$NC "'
alias clc='clear && clear'
alias pd='pushd'
alias upd='popd 2>/dev/null'

alias grep='grep --color'
alias ls='ls --color'
alias trim-trailing-spaces="sed -i 's/[[:space:]]*\$//'"

alias venv='source venv/bin/activate'

# More custom commands
function mkcd () {
  if [ $# -lt 1 ]; then
    return
  fi
  mkdir $@
  cd "${@: -1}"
}
alias mkvenv='create_venv.sh'

# Local configuration for the machine
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi
