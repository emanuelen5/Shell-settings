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

# Removing ^s as suspend terminal, and instead using it as forward-i-search
# https://unix.stackexchange.com/questions/73498/how-to-cycle-through-reverse-i-search-in-bash
# https://stackoverflow.com/questions/24623021/getting-stty-standard-input-inappropriate-ioctl-for-device-when-using-scp-thro
[[ $- == *i* ]] && stty -ixon

alias clc='reset;clear;clear;'

# Improving history
export HISTSIZE=10000
export HISTTIMEFORMAT="(%Y-%m-%d %T) "

# For stopping annoying loud bells
set bell-style visible

# Linking scripts
alias start-ssh-agent=". ~/bin/ssh_agent_load.sh"
alias ssh-add-keys='cat ~/.ssh-keys.list | while read key; do ssh-add -l | grep -q $(ssh-keygen -lf $key  | awk "{print \$2}") || ssh-add $key; done'
alias sshag="start-ssh-agent "
~/bin/ssh_agent_load.sh -r > /dev/null

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

# Starship configuration
export STARSHIP_CONFIG=~/.starship
if [ -f $STARSHIP_CONFIG ]; then
	eval "$(starship init bash)"
fi

eval "$(direnv hook bash)"

function tmux-new-terminal-with-commands() {
    if [ $# -lt 3 ]; then
        echo $'Too few arguments. Usage: \n$ tmux-new-terminal-with-commands SESSION_NAME WINDOW_NAME COMMAND [COMMAND ....]' >&2
        return 1
    fi
    session=$1
    shift
    name=$1
    shift
    commands="$@ "   # Extra white space on end so bash splits the last command if there is a trailling (intentional) IFS
    if ! $(tmux has-session -t "$session" 2>/dev/null); then
        echo "1. Creating session and window"
        tmux new-session -s "$session" -n "$name" -d
    elif ! $(tmux display-message -pt "$session:$name" &>/dev/null); then
        echo "1. Creating window"
        tmux new-window -t "$session": -n "$name" -d
    else
        echo "Window $session:$name already exists. Skipping initialization of it." >&2
        return
    fi
    echo "2. Sending commands"
    (export IFS=";"
    for cmd in $commands; do
        tmux send-keys -t "$session:$name" Enter  # Send enter before so that the last command does not get entered unless there is an explicit trailing IFS
        tmux send-keys -t "$session:$name" "${cmd}${IFS}"
    done)
}

function _tmux-initialize() {
    if $(tmux has-session -t test 2>/dev/null); then
        echo "A session named 'test' is already started. Skipping initialization" >&2
        return 1
    fi
    set -ex
	# Specify here what tmux sessions you want!
    tmux new-session -s test
    tmux-new-terminal-with-commands test htop htop
}

function tmux-initialize() {
    (  # Run in subshell so it does not quit the shell if exiting with failure
        _tmux-initialize
    )
}
