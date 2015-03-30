#! /bin/bash

U=malex984
I=dockapp

# For Linux host with X11:
export XSOCK=/tmp/.X11-unix
export XAUTH=/tmp/.docker.xauth

if [ ! -f $XAUTH ]; then
   touch $XAUTH
   xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge -
fi
                                                                                                                                            
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

while :
do  
  docker run --rm --name menu -a stdin -a stdout -a stderr -i -t "$U/$I:menu"
  APP="$?"
  # 201 -> a, 202 -> b, quite otherwise 
  # TODO: any better communication means?  
  case "$APP" in
    201) docker run --rm --name appA -i "$U/$I:appa" ;;
    202) docker run --rm --name appB -i "$U/$I:appb" ;;
    203) 
         echo "Please make sure to run this script from your local X11 server (terminal) since xeys's X-client will use '$XSOCK, $XAUTH'..."
         docker run -v -e DISPLAY -e USER  $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH --rm --name xeyes "$U/$I:xeyes" ;;

    *) echo "Thank You! Quiting... "; echo ; echo "Leftover containers: "; docker ps -a;  exit 0 ;; 
  esac  
done
