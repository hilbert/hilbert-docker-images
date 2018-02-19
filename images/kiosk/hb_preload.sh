#! /bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

#set -v
#set -x

#ARGS="$@"

#HB: SET VARS...
export HB_HOST="${HB_HOST:-127.0.0.1}"
export HB_PORT="${HB_PORT:-8888}"
export HB_URL="${HB_URL:-http://${HB_HOST}:${HB_PORT}}"
export APP_ID="${APP_ID:-hb_www_app}"

echo "Will be sending heatbeats for application: [${APP_ID}] to HB server at: [${HB_URL}]!"

# HeartBeat library to preload should be locally available
export HB_LIBRARY_FILE="${HB_LIBRARY_FILE:-$SELFDIR/hilbert-heartbeat.js}"

if [[ -r "${HB_LIBRARY_FILE}" ]]; then 
  echo "Will use local heartbeat JS library: ${HB_LIBRARY_FILE}!"
else
  echo "ERROR: no local heartbeat JS library: ${HB_LIBRARY_FILE} found! Will not pre-load anything!"
  exit 1

#  echo "Starting [$@]: "
#  exec "$@"
#  exit $?

fi

### HB settings
export HB_PING_INTERVAL="${HB_PING_INTERVAL:-6000}" # in ms
export HB_SEND_INIT="${HB_SEND_INIT:-false}"
export HB_SEND_DONE="${HB_SEND_DONE:-false}"

echo "HB_SEND_INIT: [${HB_SEND_INIT}], HB_SEND_DONE: [${HB_SEND_DONE}], HB_PING_INTERVAL: [${HB_PING_INTERVAL}]"

PRELOAD_FILE=$(mktemp -p /tmp kiosk_preload_hb.XXXXXXXXX.js)

cat << EOF > ${PRELOAD_FILE}
{
    // include modules
    const fs = require('fs');
    const path = require('path');
    const vm = require('vm');

    // include the heartbeat JS library
    var content = fs.readFileSync('${HB_LIBRARY_FILE}','utf8');
    vm.runInThisContext(content,{filename:'hilbert-heartbeat.js'});

    // wait for the document finish loading and ...
    var webContents = require('electron').remote.getCurrentWindow().webContents;
    webContents.on('did-finish-load',() => {
        // ... define the heartbeat configuration
        const heartbeatCfg = {
            url: Heartbeat.getPassedUrl('${HB_URL}'),
            appId: Heartbeat.getPassedAppId('${APP_ID}'),
            interval: ${HB_PING_INTERVAL},
            sendInitCommand: ${HB_SEND_INIT},
            sendDoneCommand: ${HB_SEND_DONE},
            debugLog: console.log
        };

        // ... init the heartbeat
        window.heartbeat = new Heartbeat(heartbeatCfg);
    });
}
EOF
echo "Created temporary preload file: [${PRELOAD_FILE}], with the following contents: "
cat "${PRELOAD_FILE}"

function finish()
{
    echo "Shutting down..."
    [ $pid -ne 0 ] && kill -SIGTERM "$pid"
    [ $pid -ne 0 ] && (wait "$pid"; pid="0")
    rm -f "${PRELOAD_FILE}"
    echo -e "\nDone."
    exit 0 # 128 + 15 -- SIGTERM      
}

# trap 'kill ${!}; finish' EXIT SIGTERM SIGINT
trap '{ kill ${!} ; finish ;  exit 255 ; }' EXIT SIGTERM SIGINT SIGHUP

pid=0

#### Application starts here:
echo "Starting in background: [$@ --preload ${PRELOAD_FILE}]... and waiting for that to finish..."

#exec "$SELFDIR/run.sh" "$@"
#/bin/bash -c "$@ --preload ${PRELOAD_FILE}" &
exec "$@" --preload "${PRELOAD_FILE}" &

pid="$!"

echo "=> PID: $pid"

while ps -o pid | grep -q "^[[:space:]]*"$pid"[[:space:]]*$"
do
  sleep 6
done

# try to wait explicitly (just to be sure that such BG process is not running anymore):
#tail -f /dev/null & 
wait ${pid}
pid=0

# just to be sure:
rm -f "${PRELOAD_FILE}"

exit 0

