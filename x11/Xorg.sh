#!/bin/bash
### usage : Xorg /tmp/.new.xorg.id
XORG=$1
shift

TMP=$1
shift

CMD=$@

exec 6<> "$TMP"
$XORG -displayfd 6 1>/dev/null 2>&1
# xhost +si:localuser:username
xhost +
xcompmgr &
compton &

$CMD &

exec 6>&-

