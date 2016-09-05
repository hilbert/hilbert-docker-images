#!/bin/bash -xv


SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

CMD=$(basename "$0" '.sh')
TARGET_HOST_NAME="$1"
shift

ARGS=$@

CMD="/sbin/$CMD" 

exec "${SELFDIR}/remote.sh" "${TARGET_HOST_NAME}" sudo -n -P ${CMD} ${ARGS}

