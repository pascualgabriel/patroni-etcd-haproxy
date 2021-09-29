#!/bin/bash

clear

# docker-compose down --volumes --remove-orphans && docker-compose up --build
sudo vagrant up
docker-compose up --build
