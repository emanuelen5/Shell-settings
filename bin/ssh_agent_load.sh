#!/bin/bash
# Use argument "-r" to only try to restore, not create a new process
# User argument "-R" to restart (kill existing agents, and start a new)

# Attempt to find old agents (not zombies though, cause they can't be connected to)
find_ssh_agents () {
  pgrep -r S,R ssh-agent |
  while read p; do
    # Filter out zombies
    if ! [[ $(ps -p $p -o stat=) =~ [Z] ]]; then
      echo $p;
    fi
  done
}

echo "Open SSH agents: $(find_ssh_agents | tr '\n' ' ')"

# Get the corresponding SSH_AUTH_SOCKET for a PID
get_ssh_auth_socket () {
  ssh_agent_pid="$1"
  expected_socket_id=$(($ssh_agent_pid - 1))
  echo `find /tmp/ -type s -name "agent.$expected_socket_id" 2>/dev/null`
}

TMP_RESTORE=`echo "$@" | grep -Po '\-[^-]*r'`
TMP_RESTART=`echo "$@" | grep -Po '\-[^-]*R'`

if [ -n "$TMP_RESTART" ]; then
  kill $(find_ssh_agents)
fi

# Check if there are any open agents
if [ -z "$TMP_RESTART" ] && [ `find_ssh_agents | wc -l` -gt 0 ]; then

  # Recover the first one's ID and file handle
  SSH_AGENT_PID=`find_ssh_agents | sort -n | head -1`
  SSH_AUTH_SOCK=`get_ssh_auth_socket $SSH_AGENT_PID`
  if [ -z "`ps --pid $SSH_AGENT_PID | grep 'ssh-agent'`" ]; then
    echo "Could not find the process corresponding to the agent..."
    echo "Something might be wrong."
  fi

  echo "Restoring agent $SSH_AGENT_PID ($SSH_AUTH_SOCK)"

elif [ -n "$TMP_RESTORE" ]; then

  echo "Could not find an SSH agent to restore"

else

  unset SSH_AGENT_PID

  ## Start the SSH agent
  eval `ssh-agent -s` >& /dev/null
  ssh-add-keys

  if [ -n "$SSH_AGENT_PID" ]; then
    echo "Added new agent $SSH_AGENT_PID ($SSH_AUTH_SOCK)"
  else
    echo "No agent was added"
  fi

fi;

unset TMP_RESTORE
unset TMP_RESTART
