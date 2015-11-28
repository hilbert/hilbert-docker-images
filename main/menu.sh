#! /bin/bash

U=malex984
I=dockapp

IMG="$U/$I:appchoo"

#PP="$1"
#shift
#CH="$@"

ID=$(docker ps -a | grep "$IMG" | awk '{ print $1 }')
# echo $N

if [ -z "$ID" ]; then 
  # options for running terminal apps via docker run:
  RUNTERM="-a stdout -a stderr --label is_top_app=1"

  if [ -z "${DISPLAY}" ]; then 
     RUNTERM=" -it -a stdin $RUNTERM"
  elif [ "${MENU_TRY}" = "text" ]; then 
     RUNTERM=" -it -a stdin $RUNTERM"
  fi

  OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

  #docker run --rm $RUNTERM --net=none "$U/$I:menu" $OPTS -- "/usr/local/bin/menu.sh" "$@"
  #exit $?
  [ -z "$X" ] && X="X" 

  #   --name menu \
  ID=$(docker create $RUNTERM --net=none -e $X -v /tmp/:/tmp/:rw "$IMG" $OPTS -- "menu.sh" "$@")
  #docker ps -a
fi

echo "Container for menu: $ID. Starting it..."
docker start -ai $ID
RET=$?

#echo $RET

#docker ps -a

# -d 
#docker exec -it $ID "/usr/local/bin/menu.sh" "$@"
#RET=$?
#echo $RET
#docker ps -a

# exit $RET

docker stop -t 5 $ID
# > /dev/null 2>&1
docker rm -f $ID 
# > /dev/null 2>&1 

exit $RET
# docker pause menu
# $OPTS -- /menu.sh

