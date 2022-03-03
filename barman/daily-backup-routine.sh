#!/bin/bash

LOG_PATH='/var/log/barman/backup.log'

main () {

    echo "STARTING BACKUP ROUTINE AT $(date)"

    /usr/bin/barman backup haproxy-streaming

    echo -e "ENDING BACKUP ROUTINE AT $(date)
"

}

main >> "$LOG_PATH" 2>&1
