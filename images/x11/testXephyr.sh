#!/bin/bash

set -e 
#set -x
ID=$(docker run -d -e DISPLAY -v /tmp:/tmp -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri --ipc=host --name Xephyr hilbert/xephyr)

# TODO: 
sleep 2
DISPLAY=:$(docker exec -ti $ID sh -c "read < /display.log && echo \$REPLY" | tr -d '\r')

echo "You can connect your X client to $DISPLAY now."
read -p "Press [Enter] when done ..."

docker stop $ID
docker rm $ID
