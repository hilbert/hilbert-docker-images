#!/bin/bash
### usage : Xorg /tmp/.new.xorg.id
XORG=$1
TMP=$2

exec 6<> "$TMP"
$XORG -displayfd 6 1>/dev/null 2>&1
xhost +
exec 6>&-

