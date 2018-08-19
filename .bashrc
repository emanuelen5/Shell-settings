[ -f /etc/skel/.bashrc ] && source /etc/skel/.bashrc
. ~/Scripts/bash_colors.sh

# Defaults
export EDITOR=$(which vim)
export VISUAL=$(which vim)
export DISPLAY=localhost:0.0
alias python='winpty python.exe'

# Setting up a clean terminal
#PS1='\['$LIGHT_GREEN'\]'\$'\['$NC'\] '
. ~/Scripts/PS1_setup.sh
. ~/Scripts/cd_enter_exit.sh

# Removing ^s as suspend terminal
stty -ixon

# Improving history
export HISTSIZE=10000
export HISTTIMEFORMAT="(%Y-%m-%d %T) "

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
