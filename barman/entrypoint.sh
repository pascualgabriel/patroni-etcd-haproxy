#!/bin/bash

bash bootstrap.sh

supervisord -c /etc/supervisord.conf
