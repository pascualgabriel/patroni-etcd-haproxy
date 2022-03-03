#!bin/bash

PACKAGEs=(
    postgis32_13
    postgis32_13-utils
    postgis32_13-devel
    pgrouting_13
    pg_cron_13
    SFCGAL
    gdal34
)

for pack in ${PACKAGEs[@]} ; do

    dnf install -qy "$pack"

done
