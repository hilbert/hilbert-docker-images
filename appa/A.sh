#! /bin/bash
set -e

#APP="$0"
#APP=`basename "${APP}" .sh`
APP="ApplicationA"
ARGS="$@"

export APP_ID="${APP_ID:-${APP}}"

### HB: SET VARS...
export HB_HOST="${HB_HOST:-localhost}"
export HB_PORT="${HB_PORT:-8888}"
export HB_URL="${HB_URL:-http://${HB_HOST}:${HB_PORT}}"



#### Test Application starts here:

echo
echo "This is '${APP}' ('${APP_ID}'), called with arguments: '${ARGS}'"
echo
echo "We are running on the following host (${HOSTNAME}, hostid: `hostid`): `uname -a`"
echo "Current user: "
id
echo

if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; then
  echo "Will be sending heatbeats for '${APP_ID}' to '${HB_URL}'!"
fi


HB() {
  CMD="$1"
  shift

  TIME="$1"
#  shift

  hb.sh "${CMD}" "${TIME}"
#  curl -s -L -XGET -- "${HB_URL}/${CMD}?${TIME}&appid=${APP_ID}"
}

  ### HB timeouts:
  export INIT_TIME=3
  export SLEEP_TIME=5

hb_pings() {
   while /bin/true; do
    hb=`HB "hb_ping" "${SLEEP_TIME}"`
    if [ $? -ne 0 ]; then
      echo "ERROR: no more heartbeat server found!" 1>&2
      break
#    else
#      echo "Heartbeat server init response: $hb"
    fi
    sleep $SLEEP_TIME
   done
}
  
  
  

  ### HB: send 1st init message:
  if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; 
  then
    hb=`HB "hb_init" "${INIT_TIME}"`
    if [ $? -ne 0 ]; then
      echo "WARNING: no heartbeat server detected => No heartbeat..." 
      unset APP_ID
    else
      echo "OK: Heartbeat server ('${HB_URL}') init response: '$hb'"
    fi
  fi  

  hb_finish() 
  {
     [ -n "${HB_PID}" ] && ps -o pid | grep -q "^[[:space:]]*"${HB_PID}"[[:space:]]*$" >/dev/null 2>&1 && kill "${HB_PID}"
     
     if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; 
     then
         hb=`HB "hb_done" "0"`
         if [ $? -ne 0 ]; then
            echo "ERROR: no more heartbeat server found!"
         else
            echo "OK: Heartbeat server done response: ${hb}"
         fi
     fi
  }

  if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ];
  then
     trap "{ hb_finish ; exit 255; }" EXIT SIGTERM SIGINT SIGHUP
  fi   
     
     
fd=0   # stdin

if [[ -t "$fd" ]]; # || -p /dev/stdin ]]; # if [ -n "${PS1}" ];
then # interactive?

  echo "Running interactively in console terminal!"

  ### HB: run ping in background
  if [ -n "${APP_ID}" ] && [ -n "${HB_URL}" ]; then
    hb_pings & 
    export HB_PID=$!
  fi
  
  echo "Press ENTER to continue or send terminal signals to quit..."
  read
  
  hb_finish 
  exit 0

else
  ## Endless loop. Waiting for SIGTERM...
  echo "Running in background without terminal!"

   while /bin/true; do
    hb=`HB "hb_ping" "${SLEEP_TIME}"`
    if [ $? -ne 0 ]; then
      echo "ERROR: no more heartbeat server found!" 1>&2
      break
    else
      echo "Heartbeat server init response: $hb"
    fi
    sleep $SLEEP_TIME
   done
   
   exit 1

fi

