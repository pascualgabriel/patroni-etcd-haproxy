#!/bin/bash

cd "$HOME"

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y \
    && echo 'StrictHostKeyChecking no' >> ~/.ssh/config

cp /opt/patroni-etcd-haproxy/patroni/dependencies/requirements.txt /etc/patroni

python3 -m venv patroni-cluster \
    && source ./patroni-cluster/bin/activate \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r /etc/patroni/requirements.txt

test ! "$HOSTNAME" && exit 1

cp /opt/patroni-etcd-haproxy/patroni/config/$HOSTNAME.yaml /etc/patroni/patroni.yaml

cp /opt/patroni-etcd-haproxy/patroni/config/postgresql.conf /etc/patroni/postgresql.appendage.conf
