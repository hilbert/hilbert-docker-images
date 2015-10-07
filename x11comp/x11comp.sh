#!/bin/bash

ARGS="$@"

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

if [ -n "$DISPLAY" ]; then
  ##
  echo "Prepearing for OpenGL..."
  # config_cups.sh
  time setup_ogl.sh

  if [ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ]; then 
    echo "Trying to run '/etc/X11/Xsession.d/98vboxadd-xclient'..."
    sh /etc/X11/Xsession.d/98vboxadd-xclient 2>&1
  fi

  ## http://stackoverflow.com/a/696855
  [[ "${MOUSE_CURSOR}" = "off" ]] && (echo "Hiding the mouse..."; unclutter -idle 0; )

  ##
  echo "Setting-up X11 windowing..."
  # xhost +
  xcompmgr -fF -I-.002 -O-.003 -D1 
  # xcompmgr &
  # TODO: choose a comp. manager...
  compton 
  
#  [[ -n "${ARGS}" ]] && openbox & 
#  ARGS="${ARGS:-openbox}"

  ## Run something in this container?...
  ${ARGS:-cat}
fi

exit $?


