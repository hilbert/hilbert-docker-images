#!/bin/bash

U=malex984
I=dockapp

docker images -a
docker ps -a -s

## TODO: another for loop for customizable images
for d in x11 test ;
do
  echo
  echo "Updating $U/$I:$d...."
  ./main/up_vb.sh "$U/$I:$d" || exit 1
  ./main/up_nv.sh "$U/$I:$d" || exit 1
  docker tag "$U/$I:$d" "$d" 
  docker rmi $(docker images -q -f dangling=true)
done

docker images -a
docker ps -a
