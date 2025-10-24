[ -f /etc/skel/.bashrc ] && source /etc/skel/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Defaults
export EDITOR=$(which vim)
export VISUAL=$(which vim)
export umask=002
export PATH="$PATH:~/bin"

# Removing ^s as suspend terminal, and instead using it as forward-i-search
# https://unix.stackexchange.com/questions/73498/how-to-cycle-through-reverse-i-search-in-bash
# https://stackoverflow.com/questions/24623021/getting-stty-standard-input-inappropriate-ioctl-for-device-when-using-scp-thro
[[ $- == *i* ]] && stty -ixon

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
export HISTSIZE=10000
export HISTTIMEFORMAT="(%Y-%m-%d %T) "
export HISTCONTROL="ignoredups:erasedups:ignorespace"
# Append to history after each command
export PROMPT_COMMAND='history -a'

# For stopping annoying loud bells
set bell-style visible

. ~/bin/hostname.sh
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile sources
# /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

for file in /etc/bash_completion.d/* ; do
    source "$file"
done

# Local configuration for the machine
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# Starship configuration
export STARSHIP_CONFIG=~/.starship
if ! "$(command -v starship)" &>/dev/null; then
	echo "starship is not installed" >&2
	. ~/bin/bash_colors.sh
	. ~/bin/PS1_setup.sh
elif [ -f $STARSHIP_CONFIG ]; then
	eval "$(starship init bash)"
fi

if ! "$(command -v direnv)" &>/dev/null; then
	echo "direnv is not installed" >&2
else
	eval "$(direnv hook bash)"
fi

source ~/bin/tmux_functions.sh

# Restore the SSH session with keys
start-ssh-agent
ssh-add-keys

