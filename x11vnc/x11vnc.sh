#!/bin/bash

if [ -z "${VNC_PASSWD}" ]; then 
  VNC_PASSWD=`mkpasswd -l 5 -d 2`
fi

echo
echo "VNC_PASSWD: ${VNC_PASSWD}"
echo


H="$HOME" 
### FIXME! TODO: insecure

# Setup a password
mkdir -p "$H/.x11vnc/"

F="$H/.x11vnc/passwd"

echo "Passwd file: $F"
x11vnc -storepasswd "${VNC_PASSWD}" "${F}"

#x11vnc -usepw -forever -display "${DISPLAY}"

#### http://www.karlrunge.com/x11vnc/x11vnc_opts.html

x11vnc -localhost -many -display "${DISPLAY}" \
-xauth "${XAUTHORITY:-$HOME/.Xauthority}" -rfbauth "${F}" \
-noxdamage -noxrecord -noxfixes -noscr -nowf \
-xkb -nap -rfbport 5900 \
-cursor most 
# -wait 50 -safer \

## -ncache 10
## -listen
# -fixscreen ? ? ?


# remote end:
# ssh -t -L 5900:localhost:5900 
# vncviewer -encodings "copyrect tight zrle hextile" localhost:0
