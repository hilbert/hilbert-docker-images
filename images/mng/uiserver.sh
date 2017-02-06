#!/bin/sh

cd /usr/local/hilbert-ui/server/

echo "Starting Dashboard's Back-end Server (in [${PWD}]) with the following arguments: '$*'"
# export NODE_PATH=/usr/lib/node_modules/hilbert-ui/node_modules
# exec node main.js $@
exec node app/main.js $@
