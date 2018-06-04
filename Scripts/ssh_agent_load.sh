#!/bin/sh

# Attempt to find old agents
find_ssh_agents () {
  find /tmp/ssh* -name "agent.*" |
    while read f; do
      echo "$f";
    done
}

# Check if there are any open agents
if [ `find_ssh_agents | wc -l` -gt 0 ]; then

  # Recover the first one's ID and file handle
  SSH_AUTH_SOCK=`find_ssh_agents | head -1`
  SSH_AGENT_ID=$((`echo "$SSH_AUTH_SOCK" | grep -Po "\\d+$"` + 1))

  echo "Restoring agent $SSH_AGENT_ID ($SSH_AUTH_SOCK)"
else

  ## Start the SSH agent
  eval `ssh-agent -s` >& /dev/null
  ssh-add

  echo "Adding new agent $SSH_AGENT_ID ($SSH_AUTH_SOCK)"
fi;

