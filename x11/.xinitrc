#! /usr/bin/env bash

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


xhost +

xcompmgr -fF -I-.002 -O-.003 -D1 &
# xcompmgr &
# TODO: choose a comp. manager...
compton &
### TODO: VB GA detection!?



if [ -e "$HOME/.Xresources" ]; then
  xrdb -load "$HOME/.Xresources"
fi

if [ -e "$HOME/.Xdefaults" ]; then
  xrdb -merge "$HOME/.Xdefaults"
fi


# xsetroot -solid black &


# TODO: xauth XAUTHORITY!?

# xwininfo

# w=18 
# h=32
# g=$( xdpyinfo | perl -n -e 'print "".($1/'$w')."x".($2/'$h')."+0+0" if /dimensions:\s*(\d+)x(\d+)/' )

# exec xterm -fs ${w}x${h} -geometry ${g}

# exec xterm  -geometry 100x50+0+0

## /usr/bin/start-pulseaudio-x11
#VBoxClient-all 
#sudo VBoxClient-all 

# ~/98vboxadd-xclient

#xconsole -geometry -0+0 -fn 5x7 &

# [ -x "/etc/X11/Xsession.d/98vboxadd-xclient" ] && sudo sh /etc/X11/Xsession.d/98vboxadd-xclient

if [ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ]; then 
	echo "Trying to run '/etc/X11/Xsession.d/98vboxadd-xclient'..."
	sh /etc/X11/Xsession.d/98vboxadd-xclient 2>&1 &
fi

exec openbox
