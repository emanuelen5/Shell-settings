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

function sshadd() {
    # Add SSH keys if they are missing

    read -sp "ssh-password: " _password
    echo "OK"

    # Check that keys are added as well
    cat ~/.ssh-keys.list | while read f; do
        echo -n "Checking key file $f: "

        ssh-add -l | grep -q "$(ssh-keygen -f "${f}" -l | cut -d' ' -f-2)"

        if [ $? -ne 0 ]; then
            echo "adding"
            expect <<EOD
                # Environment variable set to force to use terminal instead of trying X program
                spawn -noecho env SSH_ASKPASS_REQUIRE=never ssh-add "${f}"
                expect -nocase {passphrase} {
                    ## Get password interactively if it is required.
                    ## DOES NOT WORK! expect_user and gets do not wait for input!?

                    # if {! [info exists _password]} {
                    #     stty -echo
                    #     send_user "key needs password: "
                    #     set _password [gets stdin]
                    #     expect_user -re "(.*)\\r"
                    #     set _password \$expect_out(1,string)
                    #     stty echo
                    # }
                    send -- "$_password\r"
                }

                expect eof
EOD
        else
            echo "OK"
        fi
    done

    unset _password
}
