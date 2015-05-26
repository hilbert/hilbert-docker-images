#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

CMD="$1"

if [ -z "$CMD" ]; then
  CMD=xterm
  ARGS=""
else
  shift
  ARGS="$@"
fi

# requires: qclosebutton (qt4-default)
# xdotool

qclosebutton "$SELFDIR/x_64x64.png" xfullscreen "$CMD" $ARGS >> /tmp/launch.log 2>&1

exit $?


