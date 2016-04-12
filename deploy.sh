#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$PWD" 
    # HOME/.config/dockapp"
fi

cd $CFG_DIR

### station id:
TARGET_HOST_NAME="$1"
shift

TARGET_CFG_DIR="$CFG_DIR/STATIONS/${TARGET_HOST_NAME}"

DM=${DM:-}

SSH=${SSH:-${DM} ssh}
SCP=${SCP:-${DM} scp}

if [ ! -d "$TARGET_CFG_DIR" ]; then
   echo "ERROR: no configuration directory for station '${TARGET_HOST_NAME}': $TARGET_CFG_DIR!"
   exit 1
fi 

echo "Deploying '$TARGET_HOST_NAME' to station '${TARGET_HOST_NAME}' into '~/.config/dockapp/', via: ${SSH} & ${SCP}:"
# cd -

cd "${TARGET_CFG_DIR}/"
$SSH "${TARGET_HOST_NAME}" mkdir -p '~/.config/_dockapp/'
$SCP -r . "${TARGET_HOST_NAME}:.config/_dockapp/"
cd -

$SSH "${TARGET_HOST_NAME}" rm -fR '~/.config/dockapp'
$SSH "${TARGET_HOST_NAME}" mv -f '~/.config/_dockapp' '~/.config/dockapp'

cd -
