#!/bin/bash

WORKDIR=$(dirname $0)

cd "$WORKDIR"

sudo su root -c "./prepare-env.sh"

sudo su patroni -c "./config-patroni.sh"

ln -s /home/patroni/patroni-cluster/bin/patroni* /usr/sbin/

echo "patroni:$OS_PATRONI_USER_PASS" | chpasswd

systemctl enable --now sshd

systemctl enable patroni

init 6
