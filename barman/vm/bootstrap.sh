#!/bin/bash

WORKDIR=$(dirname $0)

cd "$WORKDIR"

su root -c './prepare-env.sh'

su barman -c './config-barman.sh'

echo "barman:${OS_BARMAN_USER_PASS}" | chpasswd # Get global env

echo "export OS_PATRONI_USER_PASS=$OS_PATRONI_USER_PASS" >> ~barman/.bash_profile \
    && chown barman.barman ~barman/.bash_profile
