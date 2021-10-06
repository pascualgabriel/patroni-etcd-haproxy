#!/bin/bash

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo \
    && dnf install -y docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose

sudo systemctl enable --now docker

cd /opt/patroni-etcd-haproxy/ && sudo bash docker-build-up.sh
