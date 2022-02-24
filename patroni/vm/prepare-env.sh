#!/bin/bash

dnf install -qy https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql

dnf install -qy \
    openssh-clients openssh-server \
    gcc glibc-all-langpacks langpacks-pt_BR \
    postgresql13-server postgresql13-contrib postgresql13-devel \
    python3 python3-devel python3-pip python3-psycopg2 \
    rsync \
    policycoreutils-python-utils

groupadd patroni \
    && useradd --home-dir /home/patroni -g patroni patroni

sed -i -r 's/^#(.*Port 22.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^#(.*ListenAddress 0.0.0.0.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^#(.*PasswordAuthentication yes.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^(.*PasswordAuthentication no.*)$/#\1/' /etc/ssh/sshd_config \
    && ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y

echo '10.10.0.20 patroni-01 patroni-01
10.10.0.21 patroni-02 patroni-02
10.10.0.10 etcd-01 etcd-01
10.10.0.11 etcd-02 etcd-02
10.10.0.12 etcd-03 etcd-03
10.10.0.30 barman barman' >> /etc/hosts

ln -s /usr/pgsql-13/bin/* /usr/sbin/

mkdir -p /var/lib/patroni/data \
    /var/lib/patroni/log \
    /etc/patroni \
    && chown -R patroni.patroni /var/lib/patroni /etc/patroni \
    && chmod -R 700 /var/lib/patroni /etc/patroni

cp /opt/patroni-etcd-haproxy/patroni/vm/patroni-sample.service /etc/systemd/system/patroni.service

echo 'softdog' > /etc/modules-load.d/softdog.conf

modprobe softdog

echo 'KERNEL=="watchdog", OWNER="patroni", GROUP="root", MODE="0600"' > /etc/udev/rules.d/60-watchdog.rules

semanage permissive -a rsync_t
