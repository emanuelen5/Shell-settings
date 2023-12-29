# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# The following lines were added by compinstall
zstyle :compinstall filename '/home/emaus/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory beep nomatch notify
unsetopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR=$(which vim)
export VISUAL=$(which vim)
export PATH="$PATH:~/bin"

# Removing ^s as suspend terminal, and instead using it as forward-i-search
# https://unix.stackexchange.com/questions/73498/how-to-cycle-through-reverse-i-search-in-bash
# https://stackoverflow.com/questions/24623021/getting-stty-standard-input-inappropriate-ioctl-for-device-when-using-scp-thro
[[ $- == *i* ]] && stty -ixon

# Improving history
export HISTSIZE=10000
export HISTTIMEFORMAT="(%Y-%m-%d %T) "

# For stopping annoying loud bells
set bell-style visible

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Local configuration for the machine
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# Starship configuration
if ! "$(command -v direnv)" &>/dev/null; then
	echo "direnv is not installed" >&2
else
	eval "$(direnv hook bash)"
fi

source ~/bin/tmux_functions.sh

# Restore SSH agent if configured
sshag
