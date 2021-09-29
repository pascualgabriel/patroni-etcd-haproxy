#!/bin/bash

dnf install -y keepalived haproxy psmisc

# HAProxy

sudo mv -v /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg_sample \
    && cp -v /vagrant/config/haproxy.cfg /etc/haproxy/haproxy.cfg \
    && setsebool -P haproxy_connect_any=1 \
    && systemctl enable haproxy \
    && systemctl start haproxy

# KeepAlived

sudo mv -v /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf_sample \
    && cp -v /vagrant/config/keepalived-01.conf /etc/keepalived/keepalived.conf \
    && systemctl enable keepalived \
    && systemctl start keepalived
