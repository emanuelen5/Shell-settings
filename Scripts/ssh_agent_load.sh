#!/bin/sh
# Use argument "-r" to only try to restore, not create a new process

# Attempt to find old agents
find_ssh_agents () {
  find /tmp/ssh* -name "agent.*" 2>/dev/null |
    while read f; do
      echo "$f";
    done
}

TMP_RESTORE=`echo "$@" | grep -Po '\-[^-]*r'`

# Check if there are any open agents
if [ `find_ssh_agents | wc -l` -gt 0 ]; then

  # Recover the first one's ID and file handle
  SSH_AUTH_SOCK=`find_ssh_agents | head -1`
  SSH_AGENT_PID=$((`echo "$SSH_AUTH_SOCK" | grep -Po "\\d+$"` + 1))

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
  ssh-add

  if [ -n "$SSH_AGENT_PID" ]; then
    echo "Added new agent $SSH_AGENT_PID ($SSH_AUTH_SOCK)"
  else
    echo "No agent was added"
  fi

fi;

unset TMP_RESTORE
