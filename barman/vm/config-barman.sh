#!/bin/bash

SERVERs=("patroni-01" "patroni-02")
PATRONI_USER='patroni'
OS_PATRONI_USER_PASS="$OS_PATRONI_USER_PASS" # Get global env

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y \
    && echo 'StrictHostKeyChecking no' >> ~/.ssh/config

cp /opt/patroni-etcd-haproxy/barman/config/.pgpass-sample ~/.pgpass \
    && chmod 0600 ~/.pgpass

cp /opt/patroni-etcd-haproxy/barman/config/barman.conf /etc/barman.conf

cp /opt/patroni-etcd-haproxy/barman/config/patroni-01.conf /etc/barman.d/patroni-01.conf

config-ssh () {

    sshpass -p "$OS_PATRONI_USER_PASS" ssh-copy-id -i ~/.ssh/id_rsa.pub "$PATRONI_USER"@"$1" \
    && scp "$PATRONI_USER"@"$1":~/.ssh/id_rsa.pub /tmp/"$1"_id_rsa.pub \
    && cat /tmp/"$1"_id_rsa.pub >> ~/.ssh/authorized_keys \
    && rm -f /tmp/"$1"_id_rsa.pub

}

for server in ${SERVERs[@]} ; do

    config-ssh "$server"

    if [ "$?" -ne 0 ] ; then
        echo "ERROR: Server Does not Exists!"
        exit 1
    fi

    barman check "$server" 2
    barman switch-wal --archive "$server"

done