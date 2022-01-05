#!/bin/bash

# Check incoming wals directory
barman show-server patroni-01 | grep incoming_wals_directory

# Check patroni-01 config and connection
barman check patroni-01

# Force switch-wal patroni-01 (first command)
barman switch-wal --force --archive patroni-01

# Diagnose
barman diagnose

# Backup patroni-01
barman backup patroni-01

# List all patroni-01 backup
barman list-backup patroni-01

# Show patroni-01 backup info using the backup ID
barman show-backup patroni-01 ID
