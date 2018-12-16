#!/bin/bash

SELFDIR="$(dirname "$0")"
SELFDIR="$(cd "$SELFDIR" && pwd)"

# cd "$SELFDIR"

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


# xhost +
#xcompmgr -fF -I-.002 -O-.003 -D1 &
# xcompmgr &
# TODO: choose a comp. manager...
#compton &

# requires: qclosebutton (qt4-default)
# xdotool

if [[ "x${HILBERT_MOUSE_CURSOR}" = "xoff" ]]; then
  echo "Hiding the mouse via [xbanish ${HILBERT_XBANISH_ARGS}]..."
  /usr/local/bin/xbanish ${HILBERT_XBANISH_ARGS} &>>/dev/null &
fi

if [[ "x${HILBERT_MOUSE_CURSOR}" = "xunclutter" ]]; then
  : ${HILBERT_UNCLUTTER_ARGS:= -idle 0 -jitter 50 -root}
  echo "Hiding the mouse via [unclutter ${HILBERT_UNCLUTTER_ARGS}]..."
  ## http://stackoverflow.com/a/696855
  ## https://stackoverflow.com/a/13935981
  unclutter ${HILBERT_UNCLUTTER_ARGS} &
fi


export ALSA_CARD="${HILBERT_ALSA_CARD:-${ALSA_CARD}}"

if [[ ! -z "${ALSA_CARD}" ]]; then 

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
if [[ ! -f "$HOME/.asoundrc" ]]; then
  mv "$HOME/.asoundrc~" "$HOME/.asoundrc"
fi

fi

## TODO: make  qclosebutton and xfullscreen optional!
# exec qclosebutton "$SELFDIR/x_64x64.png" 
# exec xfullscreen 

if [[ -z "$*" ]]; then
  if [[ -z "${DISPLAY}" ]]; then 
    CMD=bash
  else
    CMD=xterm
  fi
  exec "${CMD}" 2>&1
  exit $?
fi

exec "$@" 2>&1
exit $?


