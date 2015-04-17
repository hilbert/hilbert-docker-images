#!/bin/bash

U=malex984
I=dockapp

##### old: debian:wheezy ???
#docker pull phusion/baseimage
#docker tag phusion/baseimage:0.9.16 "$U/$I:base"


docker images -a
docker ps -a -s

# ALL: base dd main appa menu alsa xeyes gui play iceweasel skype q3 x11 cups x11vb;

# for dependencies please check out depsgen.sh!
#qclosebutton xeyes appchoo  ;
# for d in main alsa xeyes x11 x11vb ;
for d in base dd main menu appa alsa xeyes x11 gui ;
do
  echo
  echo "Building $d -> $U/$I:$d...."
  cat "$d/Dockerfile"
  echo
  docker ps -s -a | grep "$d"
  # docker stop "$d"
  # docker rm -f "$d"

  cd "$d"
  docker build --pull=false -t "$U/$I:$d" "."
  cd -
  echo
#  docker push "$U/$I:$d"
done

docker images -a
docker rmi $(docker images -q -f dangling=true)
docker images -a
docker ps -a



#E: Unable to locate package sdl
#E: Unable to locate package sdl_image
#E: Unable to locate package libpng
#E: Unable to locate package jpeg

#E: Unable to locate package mesa-dri-swrast
#E: Unable to locate package xorg-server-xephyr
#E: Package 'xkeyboard-config' has no installation candidate
#E: Unable to locate package xkbcomp

# E: Unable to locate package libqt5gui5
# E: Unable to locate package libqt5widgets5

