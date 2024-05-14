#!/usr/bin/env bash

function get_ssh_agent_status() {
    ssh-add -l &> /dev/null; echo $?
}

function get_ssh_agent_pids() {
    ps aux | grep -E '/?ssh-agent' | awk '{print $1}'
}

function get_agent_sock_path() {
    pid="$1"
    # Check if there is a socket that matches it
    ls /tmp/ssh-*/agent.$(( $pid - 1 )) 2>/dev/null
}

ssh_status=$(get_ssh_agent_status)
echo -n "ssh-agent: "
if [ ${ssh_status} -ne 2 ]; then
    echo 'already configured'
else
    pids=$(get_ssh_agent_pids)

    echo pids=$pids
    for pid in $pids; do
        read -r sock_path <<<$(get_agent_sock_path $pid)
        export SSH_AGENT_PID="$pid"
        export SSH_AUTH_SOCK="$sock_path"

        ssh_status=$(get_ssh_agent_status)
        echo ssh_status=$ssh_status
        if [ ${ssh_status} -ne 2 ]; then
            echo "restored (pid=$pid)"
            break
        elif [ ${ssh_status} -eq 2 ]; then
            # echo "failed to configure. Agent does not repond." >&2
            echo -n "kill=${SSH_AGENT_PID}, "
            kill ${SSH_AGENT_PID}
        fi

        unset pid
    done

    ssh_status=$(get_ssh_agent_status)
    if [ ${ssh_status} -eq 2 ]; then
        echo -n 'starting new... '
        eval $(ssh-agent -s) &>/dev/null
        echo "done"
    fi

    # Set for all Windows processes also
    setx SSH_AGENT_PID "$SSH_AGENT_PID" &>/dev/null
    setx SSH_AUTH_SOCK "$SSH_AUTH_SOCK" &>/dev/null

fi
