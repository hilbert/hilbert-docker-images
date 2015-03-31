#! /bin/bash

U=malex984
I=dockapp

X=""

case "$OSTYPE" in
 linux*) # For Linux host with X11:
  export XSOCK=/tmp/.X11-unix
  export XAUTH=/tmp/.docker.xauth

  if [ ! -f $XAUTH ]; then
     touch $XAUTH
     xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge -
  fi
  export X="DISPLAY -e USER -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH"
  echo "Please make sure to run this script from your local X11 server (terminal) since xeys's X-client will use '$XSOCK, $XAUTH'..."
  echo
  echo "We now enable anyone to connect to this X11..."
  xhost + 
  #localhost # this does not work :(
 ;;
 darwin*) # our X11 host ip on Mac OS X via boot2docker:
  ## $(boot2docker ip)
  export X="DISPLAY=192.168.59.3:0"
  echo "Please make sure to start xsocat.sh from your local X11 server since xeys's X-client will use '$X'..."
  echo "X11 should 'Allow connections from network clients & Your firewall should not block incomming connections to X11'"
  # X11 instead of XQuartz?
  open -a XQuartz # --args xterm $PWD/xsocat.sh #?
 ;; 
esac 

#
echo 
echo "This is the main loop ($0) running on the following host (${HOSTNAME}):"
uname -a 

echo "Current docker images: "
docker images -a

echo "Pulling necessary images: "
docker pull "$U/$I:menu"
docker pull "$U/$I:appa"
docker pull "$U/$I:appb"
docker pull "$U/$I:xeyes"

echo "Current docker containers: "
docker ps -a

echo

# options for /sbin/my_init 
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

# options for running terminal apps via docker run:
export RUNTERM="--rm -it  -a stdin -a stdout -a stderr"

while :
do  
  docker run $RUNTERM --name menu "$U/$I:menu" $OPTS -- /menu.sh
  APP="$?"
  # 201 -> a, 202 -> b, quite otherwise 
  # TODO: any better communication means?  
  case "$APP" in
    201) docker run $RUNTERM --name  appA       "$U/$I:appa" ;;
    202) docker run $RUNTERM --name  appB       "$U/$I:appb"  $OPTS -- /B.sh ;;
    203) docker run --rm -it --name xeyes -e $X "$U/$I:xeyes" $OPTS -- /usr/bin/xeyes ;;
    *) echo "Thank You! Quiting... "; echo ; echo "Leftover containers: "; docker ps -a;  exit 0 ;;
  esac  
done
