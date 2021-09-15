#!/bin/bash

MINUTES_TO_WAIT=1
INTERVAL=$((60 * "$MINUTES_TO_WAIT"))

extract_report () {

    CSVs_LOG=$(find /var/lib/patroni-*/log/*.csv 2> /dev/null)

    if [ ! -z "$CSVs_LOG" ] ; then
        pgbadger -f csv -o /var/www/html/.tmp_index.html $CSVs_LOG
        cat /var/www/html/.tmp_index.html > /var/www/html/index.html
    fi

}

main () {

    nginx

    while true ; do
        extract_report
        sleep "$INTERVAL"
    done

}

main
