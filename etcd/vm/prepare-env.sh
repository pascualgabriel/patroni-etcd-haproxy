#!/bin/bash

dnf update -qy \
    && dnf install -qy jq

LATEST_ETCD_VERSION=$(curl -s "https://storage.googleapis.com/storage/v1/b/etcd/o/?delimiter=/" | jq -r '.prefixes[-1]' | tr -d '/') \
    ETCD_GCP_STORAGE_URI="https://etcd.storage.googleapis.com/$LATEST_ETCD_VERSION/etcd-$LATEST_ETCD_VERSION-linux-amd64.tar.gz" \
    && mkdir -p /opt/etcd \
    && curl -s "$ETCD_GCP_STORAGE_URI" \
    | tar -xzvC /opt/etcd --strip-components 1 \
    && cd /opt/etcd \
    && rm -rf Documentation *.md

echo '10.10.0.10 etcd-01 etcd-01
10.10.0.11 etcd-02 etcd-02
10.10.0.12 etcd-03 etcd-03
10.10.0.20 patroni-01 patroni-01
10.10.0.21 patroni-02 patroni-02' >> /etc/hosts

ln -s /opt/etcd/* /usr/sbin/

mkdir -p /etc/etcd \
    && mkdir -p /var/lib/etcd/

groupadd etcd \
    && useradd -s /sbin/nologin -g etcd etcd \
    && chown -R etcd.etcd /etc/etcd /var/lib/etcd

test ! "$HOSTNAME" && exit 1

cp /opt/patroni-etcd-haproxy/etcd/config/$HOSTNAME.yaml /etc/etcd/etcd.yaml

cp /opt/patroni-etcd-haproxy/etcd/vm/etcd-sample.service /etc/systemd/system/etcd.service
