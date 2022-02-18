#!/bin/bash

clear

docker-compose build --parallel
docker-compose --compatibility up -d
