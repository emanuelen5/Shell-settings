#!/bin/sh
# Use argument "-r" to only try to restore, not create a new process

# Attempt to find old agents
find_ssh_agents () {
  ps x | grep "ssh-agent" |
    sed "$ d" | # Remove last line (current command will match as well)
    sed -rn 's/ *([0-9]+).*/\1/p' | # Get PIDs
  while read pid; do
    echo "$pid";
  done
}

# Get the corresponding SSH_AUTH_SOCKET for a PID
get_ssh_auth_socket () {
  ssh_agent_pid="$1"
  expected_socket_id=$(($ssh_agent_pid - 1))
  echo `find /tmp/ -type s -name "agent.$expected_socket_id" 2>/dev/null`
}

TMP_RESTORE=`echo "$@" | grep -Po '\-[^-]*r'`

# Check if there are any open agents
if [ `find_ssh_agents | wc -l` -gt 0 ]; then

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
