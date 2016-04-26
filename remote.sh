#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="${HOME}/.config/dockapp"
fi

cd $CFG_DIR

### station id
TARGET_HOST_NAME="$1"
shift

CMD_ARGS=$@

echo "Command: '${CMD_ARGS}' to run on station '${TARGET_HOST_NAME}'"

DM=${DM:-}
SSH=${SSH:-${DM} ssh}

# "$CFG_DIR/deploy.sh" "${TARGET_HOST_NAME}"

# D='~/.config/dockapp/'
$SSH "${TARGET_HOST_NAME}" ${CMD_ARGS}
