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

echo "Command: '$CMD'"

TARGET_HOST_NAME="$1"
shift
### station id

TARGET_CFG_DIR="$CFG_DIR/STATIONS/${TARGET_HOST_NAME}"

if [ ! -d "$TARGET_CFG_DIR" ]; then
   echo "ERROR: no configuration directory for station '${TARGET_HOST_NAME}': $TARGET_CFG_DIR!"
   exit 1
fi 

if [ ! -x "$TARGET_CFG_DIR/$CMD.sh" ]; then
   echo "ERROR: no command '$CMD.sh' for station '${TARGET_HOST_NAME}' in '$TARGET_CFG_DIR'!"
   exit 1
fi

DM=${DM:-}
SSH=${SSH:-${DM} ssh}

"$CFG_DIR/deploy.sh" "${TARGET_HOST_NAME}"

D='~/.config/dockapp/'
$SSH "${TARGET_HOST_NAME}" "$D/$CMD.sh" $@
