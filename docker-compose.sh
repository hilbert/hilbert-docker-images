#!/bin/bash
#
# Run docker-compose in a container
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

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$SELFDIR" # HOME/.config/dockapp
fi

if [ -r "$CFG_DIR/docker.cfg" ]; then
    . "$CFG_DIR/docker.cfg"
fi


#VERSION="1.6.2"
if [ -z "$DOCKER_COMPOSE_IMAGE" ]; then
    DOCKER_COMPOSE_IMAGE="malex984/dockapp:ddd"
#"docker/compose:$VERSION"
fi

# Setup options for connecting to docker host
if [ -z "$NO_PROXY" ]; then
    NO_PROXY="/var/run/docker.sock"
    DOCKER_HOST="unix://$NO_PROXY"
    DOCKER_PLUGINS="/run/docker/plugins/"
fi

if [ -S "$NO_PROXY" ]; then
    DOCKER_ADDR="-v $NO_PROXY:$NO_PROXY -e DOCKER_HOST -e NO_PROXY -v $DOCKER_PLUGINS:$DOCKER_PLUGINS"
else
    DOCKER_ADDR="-e DOCKER_HOST -e DOCKER_TLS_VERIFY -e DOCKER_CERT_PATH"
fi


# Setup volume mounts for compose config and context
VOLUMES="-v $CFG_DIR:/DOCKAPP -e CFG_DIR=/DOCKAPP"

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

echo "CMD: [exec docker run --rm $DOCKER_RUN_OPTIONS $DOCKER_ADDR $COMPOSE_OPTIONS $VOLUMES $DOCKER_COMPOSE_IMAGE '$@']"

exec docker run --rm $DOCKER_RUN_OPTIONS $DOCKER_ADDR $COMPOSE_OPTIONS $VOLUMES $DOCKER_COMPOSE_IMAGE "$@"
