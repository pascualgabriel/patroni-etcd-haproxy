#!/bin/bash

WORKDIR=$(dirname $0)

cd "$WORKDIR"

sudo su root -c "./prepare-env.sh"
