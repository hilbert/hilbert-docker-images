#!/bin/bash

SELFDIR=`dirname "$0"`
cd "$SELFDIR"

# SELFDIR=`cd "$SELFDIR" && pwd`
#echo -e 'apple_logo.jpg APP\nwindows_logo.jpg WIN\nlinux_logo.jpg LIN\nIMG.jpg IMG\n7.jpg 7\n@NW north_west_corner\n@NE north/east corner\n@SE south/east corner\n@SW south/west corner'

APP=appchoo
ARGS="$@"

if [ ( (-z "$ARGS" ) -o ( ! -r "$ARGS" ) ) -a (-e "./$APP.list" ) ]; 
then
  ARGS=./$APP.list
else
  echo "Sorry: cannot read arguments from '$ARGS' and './$APP.list' :( "
  exit 1
fi

CHOO=$(./$APP.bin < $ARGS)
echo "Choice: $CHOO"

exit $(( $CHOO ))

