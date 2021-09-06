#!/bin/bash

clear

docker-compose down --volumes && docker-compose up --build
