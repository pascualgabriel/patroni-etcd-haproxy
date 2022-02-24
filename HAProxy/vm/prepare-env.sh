#!/bin/bash

dnf install -qy keepalived haproxy psmisc

# HAProxy

mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg_sample \
    && cp /opt/patroni-etcd-haproxy/HAProxy/config/haproxy.cfg /etc/haproxy/haproxy.cfg \
    && setsebool -P haproxy_connect_any=1 \
    && systemctl enable --now haproxy

# KeepAlived

test ! "$HOSTNAME" && exit 1

mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf_sample \
    && cp /opt/patroni-etcd-haproxy/HAProxy/config/keepalived-$HOSTNAME.conf /etc/keepalived/keepalived.conf \
    && systemctl enable --now keepalived
