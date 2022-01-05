#!/bin/bash

SERVERs=("patroni-01" "patroni-02")
PATRONI_USER='patroni'
OS_PATRONI_USER_PASS="$OS_PATRONI_USER_PASS" # Get global env

config-ssh () {

    sshpass -p "$OS_PATRONI_USER_PASS" ssh-copy-id -i ~/.ssh/id_rsa.pub "$PATRONI_USER"@"$1" \
    && scp "$PATRONI_USER"@"$1":~/.ssh/id_rsa.pub /tmp/"$1"_id_rsa.pub \
    && cat /tmp/"$1"_id_rsa.pub >> ~/.ssh/authorized_keys \
    && rm -f /tmp/"$1"_id_rsa.pub

}

main () {

    BOOTSTRAPPED_DIR="$HOME/BOOTSTRAPPED"

    test -d "$BOOTSTRAPPED_DIR" && exit 0

    for server in ${SERVERs[@]} ; do

        config-ssh "$server"

        if [ "$?" -ne 0 ] ; then
            echo "ERROR: Server Doesn't Exists!"
            exit 1
        fi

    done

    mkdir -p "$BOOTSTRAPPED_DIR"

    echo -e "# BOOTSTRAP DONE
    This entire directory is to
    make sure the bootstrap routine has already been run
" > "$BOOTSTRAPPED_DIR/README.md"

}

main
