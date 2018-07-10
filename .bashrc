[ -f /etc/skel/.bashrc ] && source /etc/skel/.bashrc
. ~/Scripts/bash_colors.sh

# Defaults
export EDITOR=$(which vim)
export VISUAL=$(which vim)
export umask=002

# Setting up a clean terminal
. ~/Scripts/PS1_setup.sh
. ~/Scripts/cd_enter_exit.sh

# For stopping annoying loud bells
set bell-style visible

# Linking scripts
alias start-ssh-agent=". ~/Scripts/ssh_agent_load.sh"
alias ssh-add-keys='ssh-add $(cat ~/.ssh-keys.list 2>/dev/null) || ssh-add'
start-ssh-agent -r > /dev/null

# Nice commands
alias where='echo -e "\b\r\e[K$YELLOW$USER$RED@$GREEN$HOSTNAME:$BLUE$PWD$NC "'
alias clc='clear && clear'
alias pd='pushd'
alias upd='popd 2>/dev/null'

alias grep='grep --color'
alias ls='ls --color'
