#!/bin/sh
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

## set -e

# echo $PWD

# echo "Args: "
# echo "["
# echo "$@"
# echo "]"

# export 

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

cd $CFG_DIR

# ls -la 

if [ -r "$CFG_DIR/station.cfg" ]; then
    . "$CFG_DIR/station.cfg"
fi

if [ -r "$CFG_DIR/startup.cfg" ]; then
    . "$CFG_DIR/startup.cfg"
fi

if [ -r "$CFG_DIR/lastapp.cfg" ]; then
    . "$CFG_DIR/lastapp.cfg"
fi

if [ -r "$CFG_DIR/docker.cfg" ]; then
    . "$CFG_DIR/docker.cfg"
fi

if [ -r "$CFG_DIR/compose.cfg" ]; then
    . "$CFG_DIR/compose.cfg"
fi

#if [ -r "$CFG_DIR/lastapp.cfg" ]; then
#    . "$CFG_DIR/lastapp.cfg"
#fi

# export 

exec "$CFG_DIR/compose" "$@"
