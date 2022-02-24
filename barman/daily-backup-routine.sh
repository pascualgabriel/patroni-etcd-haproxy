#!/bin/bash

echo "STARTING BACKUP ROUTINE AT $(date)"

/usr/bin/barman backup haproxy-streaming

echo -e "ENDING BACKUP ROUTINE AT $(date)
"
