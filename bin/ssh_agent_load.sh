#!/bin/sh
# Use argument "-r" to only try to restore, not create a new process
# User argument "-R" to restart (kill existing agents, and start a new)

# Attempt to find old agents
find_ssh_agents () {
  ps x | grep -P "\d ssh-agent" |
    sed "$ d" | # Remove last line (current command will match as well)
    sed -rn 's/ *([0-9]+).*/\1/p' | # Get PIDs
  while read pid; do
    echo "$pid";
  done
}

TMP_RESTORE=`echo "$@" | grep -Po '\-[^-]*r'`
TMP_RESTART=`echo "$@" | grep -Po '\-[^-]*R'`

if [ -n "$TMP_RESTART" ]; then
  kill $(find_ssh_agents)
fi

## Start the SSH agent
eval `ssh-agent -s` >& /dev/null
echo "Restoring agent $SSH_AGENT_PID ($SSH_AUTH_SOCK)"

if [ -z "$TMP_RESTORE" ]; then
  ssh-add-keys

  if [ -n "$SSH_AGENT_PID" ]; then
    echo "Added new agent $SSH_AGENT_PID ($SSH_AUTH_SOCK)"
  else
    echo "No agent was added"
  fi
fi
