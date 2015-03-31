#!/bin/bash

U=malex984
I=dockapp
##### old: debian:wheezy 
#docker pull phusion/baseimage:0.9.16
#docker tag phusion/baseimage:0.9.16 "$U/$I:base"

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




