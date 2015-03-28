#! /bin/bash

U=malex984

echo 

echo "This is the main loop ($0) running on the following host (${HOSTNAME}):"
uname -a 

echo "Current docker images: "
docker images -a

echo "Pulling necessary images: "
docker pull "$U/menu"
docker pull "$U/appa"
docker pull "$U/appb"

echo "Current docker containers: "
docker ps -a

echo

while :
do  
  docker run --rm --name menu -a stdin -a stdout -a stderr -i -t "$U/menu"
  APP="$?"
  # 201 -> a, 202 -> b, quite otherwise 
  # TODO: any better communication means?  
  case "$APP" in
    201) docker run --rm --name appA -i "$U/appa" ;;
    202) docker run --rm --name appB -i "$U/appb" ;;
    *) echo "Thank You! Quiting... "; echo ; echo "Leftover containers: "; docker ps -a;  exit 0 ;; 
  esac  
done
