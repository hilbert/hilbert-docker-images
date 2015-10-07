#!/bin/bash
### usage : Xorg /tmp/.new.xorg.id

XORG=Xorg
#shift

#shift

ARGS="$@"

echo "ORIGINALLY THERE SHOULD BE NO DISPLAY:[$DISPLAY]..."
#unset DISPLAY

#### Advanced Bash-Scripting Guide: I/O Redirection: 20.1. Using exec: http://www.tldp.org/LDP/abs/html/x17974.html

echo "Trying to run: [$XORG -displayfd 6 $ARGS]"

TMP=/tmp/new.Xorg.id
exec 6 > $TMP

echo "DISPLAY_NUM:" 1>&6  


# http://stackoverflow.com/questions/2520704/find-a-free-x11-display-number
$XORG -displayfd 6 $ARGS & 2>&1
PID=$!

sleep 3
exec 6>&-

# xhost +si:localuser:username

			xhost +
#			xcompmgr -fF -I-.002 -O-.003 -D1 &
			# TODO: choose a comp. manager...
#			compton &
			### TODO: VB GA detection!?
			[ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ] && sudo sh /etc/X11/Xsession.d/98vboxadd-xclient


# TODO: the following would not appear in the output...???!???
cat $TMP
wait $PID
exit 0

