#!/usr/bin/env bash

# The start script for the docker container.

echo "IP ADDR: `ip addr`"

SLEEP_TIME=60
MAX_TRIES=5

tries=0

echo "** Starting OMD **"
omd start
service apache2 restart

while /bin/true; do
  sleep $SLEEP_TIME
  omd status | grep -q "stopped" && {
    if [ $tries -gt $MAX_TRIES ]; then
      echo "** ERROR: Stopped service found; aborting (after $tries tries) **"
      exit 1
    fi
    tries=$(( tries + 1 ))
    echo "** ERROR: Stopped service found; trying to start again **"
    omd start
  }
done


## /bin/bash
