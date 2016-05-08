#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$PWD" 
    # HOME/.config/dockapp"
fi

cd $CFG_DIR

# ACTION="$1"
### start, stop, 
# shift

CMD=$(basename "$0" '.sh')
CMD="~/.config/dockapp/$CMD.sh"

TARGET_HOST_NAME="$1"

   if [ -z "${TARGET_HOST_NAME}" ]; then
      echo "ERROR: no station argument given to this script $0: [$@]!"
      exit 1
   fi

shift

### station id
ARGS=$@

   ./remote.sh "${TARGET_HOST_NAME}" "exit 0" &> /dev/null
   if [ $? -ne 0 ]; then
      echo "ERROR: no access to station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

   ./remote.sh "${TARGET_HOST_NAME}" "test -x $CMD && exit 0 || exit 1" &> /dev/null
   if [ $? -ne 0 ]; then
      echo "ERROR: no executable shell script '$CMD' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

echo "Running custom management command: '$CMD $ARGS' on station '${TARGET_HOST_NAME}'... "
exec ./remote.sh "${TARGET_HOST_NAME}" $CMD $ARGS
