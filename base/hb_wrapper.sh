#! /bin/bash
# set -e

ARGS="$@"

#HB: SET VARS...
export HB_HOST="${HB_HOST:-localhost}"
export HB_PORT="${HB_PORT:-8888}"
export HB_URL="${HB_URL:-http://${HB_HOST}:${HB_PORT}}"
export APP_ID="${APP_ID:-hb_wrapper}"
export HB_INIT_TIMEOUT="${HB_INIT_TIMEOUT:-3}"

pid=0

#  curl -s -L -XGET -- "${HB_URL}/${CMD}?${TIME}&appid=${APP_ID}"
HB() {
  hb.sh "$1" "$2"
}

hb_finish() 
{
      [ $pid -ne 0 ] && kill -SIGTERM "$pid"
      
      if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; 
      then
         hb=`HB "hb_done" "1"`
         if [ $? -ne 0 ]; then
            echo "ERROR: no more heartbeat server found!"
         else
            echo "OK: Heartbeat server done response: ${hb}"
         fi
      fi

      [ $pid -ne 0 ] && wait "$pid"

      pid="0"

      exit 143; # 128 + 15 -- SIGTERM      
}


### HB: send 1st init message:
if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; 
then
    echo "Will be sending heatbeats for '${APP_ID}' to '${HB_URL}'..."
    
    hb=`HB "hb_init" "${HB_INIT_TIMEOUT}"`
    if [ $? -ne 0 ]; then
      echo "WARNING: no heartbeat server detected => No heartbeat..." 
      unset APP_ID
    else
      echo "OK: Heartbeat server ('${HB_URL}') init response: '$hb'"
    fi
fi  

#     trap "{ hb_finish ; exit 255; }" EXIT SIGTERM SIGINT SIGHUP
# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; hb_finish' EXIT SIGTERM

#### Application starts here:
/bin/bash -c "$ARGS" &
pid="$!"

# wait indefinetely
# true
while ps -o pid | grep -q "^[[:space:]]*"$pid"[[:space:]]*$" >/dev/null 2>&1
do
  tail -f /dev/null & wait ${!}
done

