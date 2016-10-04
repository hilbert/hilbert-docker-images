#! /bin/sh

# please run this from insode X11 (where $DISPLAY is defined)
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
# docker run -e DISPLAY=192.168.59.3:0 xeyes
