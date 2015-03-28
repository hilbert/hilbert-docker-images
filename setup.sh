#!/bin/bash

U=malex984
# docker pull debian:wheezy 
# docker tag debian:wheezy "$U/mini"

docker images -a

for d in appa appb menu;
do
  echo
  echo "Building $d -> $U/$d...."
  cat "$d/Dockerfile"
  echo
  docker build -t "$U/$d" "$d"
  echo 
#  docker push "$U/$d"
done

docker images -a




