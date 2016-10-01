#! /bin/bash
# umask 0

# 1. step: important mixer settings - these are hardware dependent and (probably) not really necessary
#amixer sset Digital 100% unmute cap
#amixer sset Capture 99% unmute cap

export LD_LIBRARY_PATH=/usr/lib/i386-linux-gnu/apulse/:/usr/lib/i386-linux-gnu/libv4l/:/usr/lib/i386-linux-gnu/
export XLIB_SKIP_ARGB_VISUALS=1
export QT_X11_NO_MITSHM=1
# export QT_SELECT=qt4-i386-linux-gnu #?

export APULSE_PLAYBACK_DEVICE="plughw:0,0"
export APULSE_CAPTURE_DEVICE="plughw:0,1"
export PULSE_LATENCY_MSEC=30


# on the host (with all the modules!) due to dark image???
# rmmod uvcvideo;  modprobe uvcvideo nodrop=1;  echo "options uvcvideo nodrop=1" > /etc/modprobe.d/uvcvideo.conf

cd /usr/lib/i386-linux-gnu/libv4l/
LD_PRELOAD=v4l1compat.so /usr/bin/skype
cd -

