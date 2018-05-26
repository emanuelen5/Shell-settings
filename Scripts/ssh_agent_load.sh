#!/bin/sh

## Start the SSH agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s` >& /dev/null
    ssh-add
fi

