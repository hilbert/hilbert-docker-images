#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

ARGS="$@"

if [ -z "$ARGS" ]; then # cups play surfer iceweasel skype q3 xbmc up
    ARGS=" base dd main appa appchoo alsa xeyes gui test x11 dummy "
# for dependency graph please check out depsgen.sh!
fi

U=malex984
I=dockapp

docker pull phusion/baseimage:0.9.16

docker images -a
docker ps -a


for d in $ARGS ;
do
  echo
  echo "Building $d -> $U/$I:$d...."
  cd $d
  
  cat "./Dockerfile"
  echo
  docker ps -sa | grep "$d"
  # docker stop "$d"
  # docker rm -f "$d"
  echo "Building '$d'..."

  make -C $PWD || docker build --pull=false --force-rm=true --rm=true -t "$U/$I:$d" "." || exit 1
  docker rmi $(docker images -q -f dangling=true)
  
  echo "Pushing..."
#  docker push "$U/$I:$d"
  make -C $PWD push 
  cd .. 
done


docker images -a
docker ps -a
