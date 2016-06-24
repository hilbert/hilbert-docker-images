#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "${SELFDIR}" && pwd`
cd "${SELFDIR}"

nginx -t
nginx -s stop
nginx -s quit
nginx

cd /usr/local/dockapp_dashboard/server/app 
exec node main.js

#  -s signal     : send signal to a master process: stop, quit, reopen, reload

