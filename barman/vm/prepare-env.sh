#!/bin/bash

dnf install -qy epel-release \
    https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

curl 'https://dl.2ndquadrant.com/default/release/get/13/rpm' | bash \
    && sed -i 's/\[pgdg-common\]/\[pgdg-common\]\nexclude=barman* python*-barman/' /etc/yum.repos.d/pgdg-redhat-all.repo

dnf install -qy \
    openssh-clients openssh-server sshpass \
    python2-psycopg2 \
    barman barman-cli \
    rsync

sed -i -r 's/^#(.*Port 22.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^#(.*ListenAddress 0.0.0.0.*)$/\1/' /etc/ssh/sshd_config

echo '10.10.0.20 patroni-01 patroni-01
10.10.0.21 patroni-02 patroni-02' >> /etc/hosts

mkdir -p /var/lib/barman/data \
    /var/lib/barman/data/INCOMING \
    /var/lib/barman/data/BACKUPS \
    && chown -R barman.barman /var/lib/barman/data

cp /etc/barman.conf /etc/barman.sample.conf \
    && chown -R barman.barman /etc/barman.d /etc/barman.sample.conf /etc/barman.conf
