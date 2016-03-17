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

#SELFDIR=`dirname "$0"`
#SELFDIR=`cd "$SELFDIR" && pwd`

set -e

TMP_DOCKER_CFG=/tmp/.docker.cfg
rm -f ${TMP_DOCKER_CFG}

docker run --rm -v CFG:/A busybox cat /A/docker.cfg > ${TMP_DOCKER_CFG}

SAVE_NO_PROXY=${NO_PROXY}
SAVE_DOCKER_HOST=${DOCKER_HOST}

unset NO_PROXY
unset DOCKER_HOST

### cat ${TMP_DOCKER_CFG}
source ${TMP_DOCKER_CFG}
### rm -f ${TMP_DOCKER_CFG}

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
    DOCKER_ADDR="-v $NO_PROXY:$NO_PROXY -e DOCKER_HOST=${DOCKER_HOST} -e NO_PROXY=${NO_PROXY} -v $DOCKER_PLUGINS:$DOCKER_PLUGINS"
else
    DOCKER_ADDR="-e DOCKER_HOST=${DOCKER_HOST} -e DOCKER_TLS_VERIFY=${DOCKER_TLS_VERIFY} -e DOCKER_CERT_PATH=${DOCKER_CERT_PATH}"
fi


# Setup volume mounts for compose config and context
VOLUMES="-v CFG:/DOCKAPP -e CFG_DIR=/DOCKAPP"

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

unset NO_PROXY
unset DOCKER_HOST

export NO_PROXY=${SAVE_NO_PROXY}
export DOCKER_HOST=${SAVE_DOCKER_HOST}

echo "CMD: exec docker run --rm [$DOCKER_RUN_OPTIONS $DOCKER_ADDR $COMPOSE_OPTIONS $VOLUMES $DOCKER_COMPOSE_IMAGE $@]"

exec docker -D run --rm $DOCKER_RUN_OPTIONS $DOCKER_ADDR $COMPOSE_OPTIONS $VOLUMES $DOCKER_COMPOSE_IMAGE $@
