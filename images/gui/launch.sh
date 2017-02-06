#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd "$SELFDIR"

# config_cups.sh
time setup_ogl.sh

if [ ! -z "$CUPS_SERVER" ]; then
 config_cups.sh
fi

if [ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ]; then 
    echo "Trying to run '/etc/X11/Xsession.d/98vboxadd-xclient'..."
    sudo sh /etc/X11/Xsession.d/98vboxadd-xclient 2>&1
fi

export LANG="en_US.UTF-8"
[[ "$LANGUAGE" = "de" ]] && export LANG="de_DE.UTF-8"
[[ "$LANGUAGE" = "ru" ]] && export LANG="ru_RU.UTF-8"
### further languages...

export LC_CTYPE="$LANG"
export LC_ALL="$LANG"

CMD=$1

if [ -z "$CMD" ]; then
  if [ -z "$DISPLAY" ]; then 
    CMD=bash
  else
    CMD=xterm
  fi
  ARGS=""
else
  shift
  ARGS=$@
fi

# xhost +
#xcompmgr -fF -I-.002 -O-.003 -D1 &
# xcompmgr &
# TODO: choose a comp. manager...
#compton &

# requires: qclosebutton (qt4-default)
# xdotool

## http://stackoverflow.com/a/696855
[[ "${MOUSE_CURSOR}" = "off" ]] && (echo "Hiding the mouse..."; unclutter -idle 0; )


export ALSA_CARD="${HILBERT_ALSA_CARD:-${ALSA_CARD}}"

if [ ! -z "${ALSA_CARD}" ]; then 

## if [ ! -f $HOME/.asoundrc ]; then 

CARD="${ALSA_CARD}"

export HOME=${HOME:-/root}

# NOTE: the following may be part of customiations... 
cat <<EOF > $HOME/.asoundrc~
pcm.!default {
    type hw
    card $CARD
}
ctl.!default {
    type hw
    card $CARD
}
EOF
## fi
if [ ! -f "$HOME/.asoundrc" ]; then
  mv "$HOME/.asoundrc~" "$HOME/.asoundrc"
fi

fi

## TODO: make  qclosebutton and xfullscreen optional!
# exec qclosebutton "$SELFDIR/x_64x64.png" 
# exec xfullscreen 
exec $CMD $ARGS 2>&1
exit $?


