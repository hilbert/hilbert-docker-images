#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

ARGS="$@"

if [ -z "$ARGS" ]; then
  if [ ! -z "$CUSTOMIZATION" ]; then
    ARGS="$CUSTOMIZATION"
  fi
fi

if [ -z "$ARGS" ]; then 
  ARGS="alsa nv vb"
fi    



#ls -la  /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

for d in $ARGS ;
do
  echo
  echo "Setting-up $d...."
  echo
  sudo "$SELFDIR/setup_$d.sh" || exit 1
  echo
  echo
done

### TODO: set environment vars globally (profile?) 

exit 0

