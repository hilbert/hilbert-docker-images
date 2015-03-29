#!/bin/bash

U=malex984
I=dockapp
# docker pull debian:wheezy 
# docker tag debian:wheezy "$U/mini"

docker images -a

for d in appa appb xeyes menu;
do
  echo
  echo "Building $d -> $U/$I:$d...."
  cat "$d/Dockerfile"
  echo
  docker build -t "$U/$I:$d" "$d"
  echo 
#  docker push "$U/$I:$d"
done

docker images -a




