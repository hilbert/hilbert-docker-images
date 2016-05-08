#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

CMD="docker"

### station id
TARGET_HOST_NAME="$1"
shift

ARGS=$@

exec "${SELFDIR}/remote.sh" "${TARGET_HOST_NAME}" "${CMD} ${ARGS}"
