#!/bin/bash
#
# Run docker-compose within 'ddd'
#
# This script will attempt to mirror the host paths by using volumes for the
# following paths:
#   * $(pwd)
#   * $(dirname $COMPOSE_FILE) if it's set
#   * $HOME if it's set
#
# You can add additional volumes (or any docker run options) using
# the $COMPOSE_OPTIONS environment variable.
#

set -e

echo $PWD

echo "Args: "
echo "["
echo "$@"
echo "]"

export 

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

cd $CFG_DIR
ls -la 

if [ -r "$CFG_DIR/docker.cfg" ]; then
    . "$CFG_DIR/docker.cfg"
fi

if [ -r "$CFG_DIR/compose.cfg" ]; then
    . "$CFG_DIR/compose.cfg"
fi

export 

exec docker-compose "$@"
