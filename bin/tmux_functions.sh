#!/usr/bin/env bash

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

