#!/bin/bash

WORKDIR=$(dirname $0)

cd "$WORKDIR"

su root -c "./prepare-env.sh"

su patroni -c "./config-patroni.sh"

echo "patroni:$OS_PATRONI_USER_PASS" | chpasswd

ln -s /home/patroni/patroni-cluster/bin/patroni* /usr/sbin/

systemctl enable sshd && systemctl restart sshd

systemctl enable --now patroni
