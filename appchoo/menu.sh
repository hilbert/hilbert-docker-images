#!/bin/bash

SELFDIR=`dirname "$0"`
cd "$SELFDIR"

# SELFDIR=`cd "$SELFDIR" && pwd`
#echo -e 'apple_logo.jpg APP\nwindows_logo.jpg WIN\nlinux_logo.jpg LIN\nIMG.jpg IMG\n7.jpg 7\n@NW north_west_corner\n@NE north/east corner\n@SE south/east corner\n@SW south/west corner'

APP=appchoo
PR="$1"
shift

B="$1"
shift

ARGS="$@"

# A=( $L )
# N=${#A[@]}
# echo $N 

### HB: SET VARS...
export HB_HOST=${HB_HOST:-localhost}
export HB_PORT=${HB_PORT:-8888}
export HB_URL="http://${HB_HOST}:${HB_PORT}"

HB() {
  CMD="$1"
  shift

  TIME="$1"
#  shift

  ./hb.sh "${CMD}" "${TIME}"
#  curl -s -L -XGET -- "${HB_URL}/${CMD}?${TIME}&appid=${APP_ID}"
}

[ "${MENU_TRY}" = "text" ] && unset DISPLAY

if [ -z "${DISPLAY}" ]; then 

  export APP_ID="test_client_select_menu%`shuf -i '99999999-9999999999' -n '1'`"

  ### HB: 
  INIT_TIME=5

  hb=`HB "hb_init" "${INIT_TIME}"`
  if [ $? -ne 0 ]; then
    echo "WARNING: no heartbeat server detected => No heartbeat..."  1>&2
    unset APP_ID
#  else
#    echo "OK: Heartbeat server ('${HB_URL}') init response: '$hb'"
  fi

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

  ### HB: run ping in background
  if [ -n "${APP_ID}" ]; then
    hb_pings & 
    PID=$!
  fi
  
  PS3="$PR > "

  select choice in $ARGS ;
  do
  #  echo "Choice $((REPLY)): '$choice'" 
    [ -n "$choice" ] && echo "Thanks for choosing '$choice'" && {
       kill $PID

       if [ -n ${APP_ID} ]; then
         hb=`HB "hb_done" "0"`
         if [ $? -ne 0 ]; then
            echo "ERROR: no more heartbeat server found!" 1>&2
         else
            echo "OK: Heartbeat server done response: ${hb}"
         fi
       fi	 
       
       exit $(($B + REPLY))
    }

  if [ -n ${APP_ID} ]; then
    ps -o pid | grep -q "^[[:space:]]*"$PID"[[:space:]]*$" >/dev/null 2>&1 || {
      hb_pings &
      PID=$!
    }
  fi

    
  done

else

export APP_ID="test_client_GUI_menu%`shuf -i '99999999-9999999999' -n '1'`"

  ### HB: 
  INIT_TIME=5

  hb=`HB "hb_init" "${INIT_TIME}"`
  if [ $? -ne 0 ]; then
    echo "WARNING: no heartbeat server detected => No heartbeat..."  1>&2
    unset APP_ID
#  else
#    echo "OK: Heartbeat server ('${HB_URL}') init response: '$hb'"
  fi

  CHOO=$(./txt2jpg.sh $ARGS | ./$APP -p "$PS3")
  choice=$(echo $CHOO | sed 's@^.*:@@g')
  
  echo "Thanks for choosing '$choice'"
  
  REPLY=$(( $(echo "$CHOO" | sed 's@:.*$@@g') ))

#  if [ -n "${APP_ID}" ]; then ### TODO: FIXME: here???
#    hb=`HB "hb_done" "0"` 
#    if [ $? -ne 0 ]; then
#      echo "ERROR: no more heartbeat server found!" 1>&2
#    else
#      echo "OK: Heartbeat server done response: ${hb}"
#    fi
#  fi

  exit $(($B + REPLY)) 
  
fi

