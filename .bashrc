. ~/Scripts/.bash_colors.sh

# Defaults
export EDITOR=$(which vim)
export VISUAL=$(which vim)
export DISPLAY=localhost:0.0
alias python='winpty python.exe'

# Setting up a clean terminal
PS1='\['$LIGHT_GREEN'\]'\$'\['$NC'\] '

# For stopping annoying loud bells
set bell-style visible

# Linking scripts
alias start-ssh-agent=". ~/Scripts/ssh_agent_load.sh"

# Nice commands
alias where='echo -e "\b\r\e[K$YELLOW$USER$RED@$GREEN$HOSTNAME:$BLUE$PWD$NC "'
alias clc='clear && clear'
