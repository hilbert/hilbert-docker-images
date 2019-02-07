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
        // don't load the library on failed page load
        if(window.location.href=="data:text/html,chromewebdata")
            return;

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


function _trap_handler() {  # EXIT signal handler to remove temporary preload-file and make sure to terminate BG application
  rv=$?
#  echo "Ret. code: [$rv]?"
  local var="$1" # NOTE: **Name** of global variable with PID of BG process
  local pid=${!var} # NOTE: current value of PID
  shift
  local sig="$1" # signal to handle
  shift
  echo "PID of BG process: [${pid}]. TRYING TO HANDLE SIGNAL [${sig}]: "


  if [[ ${pid} -ne 0 ]]; then
    if [[ "${sig}" -ne 0 ]]; then
      echo "TRYING TO PASS the signal [${sig}] the BG process: "
      kill "-${sig}" "${pid}" && sleep 1
    fi

    echo "TRYING TO KILL the BG Main process: "
    kill "${pid}" && sleep 1
    kill -SIGKILL "${pid}"
  fi

  rm -f "${PRELOAD_FILE}"
#  echo "Ret. code: [$rv]!"
#  exit ${rv}
}


# NOTE: the collowing is due to https://stackoverflow.com/a/2183063
function _trap_handler_setup() {  # setup signal handlers
  local func="$1"
  shift
  local varname="$1"
  shift
  for sig ; do
    trap "${func} ${varname} ${sig}" "${sig}"
  done
  return 0
}



pid=0

## trap '{ finish ;  exit 255 ; }' EXIT SIGTERM SIGINT SIGHUP
_trap_handler_setup "_trap_handler" "pid" 0 # 1 2 3 13 15

#### Application starts here:
echo "Starting in background: [$@ --preload ${PRELOAD_FILE}]... and waiting for that to finish..."

#exec "$SELFDIR/run.sh" "$@"
#/bin/bash -c "$@ --preload ${PRELOAD_FILE}" &
exec "$@" --preload "${PRELOAD_FILE}" &
pid="${!}"

echo "=> PID: $pid"

while ps -o pid | grep -q "^[[:space:]]*"$pid"[[:space:]]*$"
do
  sleep 3
done

echo "WAITING for the Main process [${pid}]: "
wait "${pid}"
_ret=$?
pid=0

# just to be sure:
rm -f "${PRELOAD_FILE}"

exit ${_ret}

