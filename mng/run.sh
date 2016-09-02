#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "${SELFDIR}" && pwd`
cd "${SELFDIR}"

# ./mng.sh

nginx -t
nginx -s stop
nginx -s quit
nginx

# echo debug start
# ls -lL /usr/local/dockapp_dashboard/server/scripts
# echo debug end

cd /usr/local/dockapp_dashboard/server
export NODE_PATH=/usr/lib/node_modules/dockapp-dashboard-server/node_modules
exec node app/main.js --log_level=verbose "$*"

#  -s signal     : send signal to a master process: stop, quit, reopen, reload

