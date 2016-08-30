#!/bin/sh

set -v
set -x

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`
cd "$SELFDIR/"
## set -e

TARGET_HOST_NAME="$1"
shift
ARGS=$@

./default.sh "${TARGET_HOST_NAME}" ${ARGS} && \
./lastapp.sh "${TARGET_HOST_NAME}"

exit $?
