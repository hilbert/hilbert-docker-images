#!/bin/sh

set -v
set -x 

#SELFDIR=`dirname "$0"`
#SELFDIR=`cd "${SELFDIR}" && pwd`
#cd "${SELFDIR}"

# ./mng.sh

nginx -t
nginx -s stop
nginx -s quit
nginx

# echo debug start
# ls -lL /usr/local/dockapp_dashboard/server/scripts
# echo debug end

# export NODE_PATH=/usr/lib/node_modules/hilbert-ui/node_modules
cd /usr/local/hilbert-ui/server/app
echo "Starting Dashboard's Back-end Server with the following arguments: '$*'"
exec node main.js $@
