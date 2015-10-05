#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

SELFNAME=`basename "$0" .sh`

GL="$@"

T="$HOME/$SELFNAME.timestamp"

if [ -e "$T" ]; then
  echo "Please, run '$0' only once!"
  exit 0
fi  

if [ -z "$GL" ]; then 
  GL="/tmp/OGL.tgz"
fi

if [ -e "$GL" ]; then  
  echo "Customizing using '$GL':"
  # --skip-old-files
  ls -la "$GL"
  sudo tar xzvf "$GL" --overwrite  -C / 
  echo "Running ldconfig..."
  sudo ldconfig 
  
#  if [ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ]; then 
#    echo "Trying to run '/etc/X11/Xsession.d/98vboxadd-xclient'..."
#    sudo sh /etc/X11/Xsession.d/98vboxadd-xclient || true
#  fi
else
  echo "Sorry: no OGL file ['$GL'] found :("
fi

touch "$T"
exit 0

