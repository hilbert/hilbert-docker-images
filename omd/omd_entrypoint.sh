#!/usr/bin/env bash

# The start script for the docker container.

echo "IP ADDR: `ip addr`"

SLEEP_TIME=60
MAX_TRIES=5

tries=0

echo "** Starting OMD **"
/etc/init.d/apache2 start 2>&1
/etc/init.d/xinetd start 2>&1

omd start 2>&1
service apache2 restart 2>&1

while /bin/true; do
  sleep $SLEEP_TIME
  omd status 2>&1 | grep -q "stopped" && {
    if [ $tries -gt $MAX_TRIES ]; then
      echo "** ERROR: Stopped service found; aborting (after $tries tries) **"
      exit 1
    fi
    tries=$(( tries + 1 ))
    echo "** ERROR: Stopped service found; trying to start again **"
    omd start 2>&1
  }
done


## /bin/bash
