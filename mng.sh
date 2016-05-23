#!/usr/bin/env bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`
cd $SELFDIR

lsof -n -i | grep -E ':(9000|8080)'

# cd STATIONS && ../www.sh >../www.log 2>&1 & 
./sync.sh

cd $SELFDIR && socat TCP4-LISTEN:9000,fork EXEC:./bashttpd >bashttpd.log 2>&1 &

tail -f bashttpd.log


