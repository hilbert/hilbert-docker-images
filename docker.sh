#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$PWD" 
    # HOME/.config/dockapp"
fi

cd $CFG_DIR

# ACTION="$1"
### start, stop, 
# shift

CMD=$(basename "$0" '.sh')

### station id
TARGET_HOST_NAME="$1"
shift

ARGS=$@

echo "Command: '${CMD} ${ARGS}' to run on station '${TARGET_HOST_NAME}'"

DM=${DM:-}
SSH=${SSH:-${DM} ssh}

# "$CFG_DIR/deploy.sh" "${TARGET_HOST_NAME}"

# D='~/.config/dockapp/'
$SSH "${TARGET_HOST_NAME}" "${CMD} ${ARGS}"
