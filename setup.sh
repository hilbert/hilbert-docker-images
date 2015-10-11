#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

ARGS="$@"

if [ -z "$ARGS" ]; then # cups play surfer iceweasel skype q3 xbmc up
    ARGS=" base appchoo dd main alsa xeyes x11 dummy x11vnc x11comp gui test play kiosk kivy skype surfer omd iceweasel cups q3 xbmc "
    
###  base dd main appa appchoo alsa xeyes gui test x11 dummy cups skype iceweasel play q3 xbmc surfer "
# for dependency graph please check out depsgen.sh!
# 
fi

U=malex984
I=dockapp

docker pull phusion/baseimage:0.9.16

docker images -a
docker ps -a

df -h

for d in $ARGS ;
do
  echo
  echo
  echo
  echo
  echo
  echo "Building $d -> $U/$I:$d...."
  cd $d
  
  cat "./Dockerfile"
  echo
  echo
  echo
  docker ps -sa | grep "$d"
  # docker stop "$d"
  # docker rm -f "$d"
  echo "Building '$d'..."

  df -h
  make -C $PWD || docker build --pull=false --force-rm=true --rm=true -t "$U/$I:$d" "." || exit 1
  docker rmi $(docker images -q -f dangling=true)
  ls -al /dev/pts/ptmx
  ls -al /dev/ptmx
  df -h
#  chmod a+rwx /dev/pts/ptmx
  echo "Pushing..."
#  docker push "$U/$I:$d"
  make -C $PWD push 
  cd .. 
done


docker images -a
docker ps -a

ls -al /dev/pts/ptmx
ls -al /dev/ptmx
df -h
# sudo chmod a+rwx /dev/pts/ptmx
