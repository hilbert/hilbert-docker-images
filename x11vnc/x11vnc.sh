#!/bin/bash

# PASS="$@"
# P="${PASS:-1234}"
# H="/tmp" ### FIXME! TODO: insecure

# Setup a password
# x11vnc -storepasswd "${P}" "$H/.vnc_passwd"

#x11vnc -usepw -forever -display "${DISPLAY}"

# -localhost 
x11vnc -display "${DISPLAY}" -auth "${XAUTHORITY}" -nopw -forever -rfbport 5900
# -xkb -ncache 10 -listen -noxdamage -noxrecord -noxfixes -noscr -nowf -fixscreen
# -o /tmp/x11vnc.log

# remote end:
# ssh -t -L 5900:localhost:5900 
# vncviewer -encodings "copyrect tight zrle hextile" localhost:0
