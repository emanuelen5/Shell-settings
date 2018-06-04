#!/bin/sh

## Start the SSH agent
SSH_AUTH_SOCK_NAME=`echo $SSH_AUTH_SOCK | grep -Po 'agent\.\d+$'`
if [ -z "$SSH_AUTH_SOCK" ] || [ -z "$SSH_AUTH_SOCK_NAME" ] ; then
    eval `ssh-agent -s` >& /dev/null
    ssh-add
fi

