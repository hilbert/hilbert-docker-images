#! /bin/bash

U=malex984
I=dockapp

# our X11 host ip
DISPLAY="192.168.59.3:0" 

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
    echo "Please make sure to start xsocat.sh from your local X11 server since xeys's X-client will use '$DISPLAY'..."
    docker run -e "DISPLAY=$DISPLAY" --rm --name xeyes "$U/$I:xeyes" ;;
    *) echo "Thank You! Quiting... "; echo ; echo "Leftover containers: "; docker ps -a;  exit 0 ;; 
  esac  
done
