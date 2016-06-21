#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

TARGET_HOST_NAME="$1"
shift
ARGS=$@

CMD=$(basename "$0" '.sh')
CMD="/sbin/$CMD"

exec "${SELFDIR}/remote.sh" "${TARGET_HOST_NAME}" "sudo -n -P ${CMD} ${ARGS}"
