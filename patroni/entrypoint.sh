#!/bin/bash

/usr/sbin/sshd

./patroni-cluster/bin/patroni /home/patroni/patroni.yaml
