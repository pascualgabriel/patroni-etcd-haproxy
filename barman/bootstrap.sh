#!/bin/bash

PG_ISREADY=checking

while "$PG_ISREADY" ; do

    PG_USER='barman_backup_streaming'
    PG_DB='postgres'
    PG_HOST='haproxy'

    pg_isready -U "$PG_USER" -d "$PG_DB" -h "$PG_HOST"

    if [ "$?" -eq 0 ] ; then
        unset PG_ISREADY
    fi

done

# barman check haproxy-streaming

# barman switch-wal --archive haproxy-streaming

STREAMING_DIR="$HOME/data/BACKUPS/haproxy-streaming/"

test ! -d "$STREAMING_DIR" && mkdir -p "$STREAMING_DIR"
