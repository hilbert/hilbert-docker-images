#!/bin/bash

#F="$1"
#shift

#CMD="$1"
#shift

time setup_ogl.sh 2>&1

ARGS="$@"


DISPLAY_NUM=0
unset HAS_DISPLAY_NUM

# loop through display number 0 ... 100
# until free display number is found
while [ ! $HAS_DISPLAY_NUM ] && [ $DISPLAY_NUM -le 100 ]
do
    # check for free $DISPLAYs
    for ((;;DISPLAY_NUM++)); do
        if [[ ! -f "/tmp/.X${DISPLAY_NUM}-lock" ]]; then
            D=$DISPLAY_NUM;
            break;
        fi;
    done

	# write the display number to the log file
        echo "DISPLAY_NUM:$DISPLAY_NUM" > /tmp/x.id
	echo "DISPLAY_NUM:$DISPLAY_NUM"
	# > "$F"

	if [ ! -z "$DISPLAY" ]; then
	    CMD=Xephyr
            echo "Trying to run [$CMD :$DISPLAY_NUM $ARGS]..."
    	    $CMD :$DISPLAY_NUM $ARGS 2>&1 &
	    PID=$!
	else
	    echo "ORIGINAL DISPLAY:$DISPLAY"
	    CMD=startx
            echo "Trying to run [$CMD -- :$DISPLAY_NUM $ARGS]..."
    	    $CMD -- :$DISPLAY_NUM $ARGS 2>&1 &
	    PID=$!
	fi

        # while Xephyr is still running
	while ps -o pid | grep -q "^[[:space:]]*"$PID"[[:space:]]*$"
	do
		sleep 1
		# test if it aquired the X11 lock file
		if grep -q "^[[:space:]]*"$PID"[[:space:]]*$" `find /tmp/ | grep "^/tmp/\.X"$DISPLAY_NUM"-lock$"`
		then
	
#			export DISPLAY=":$DISPLAY_NUM"
#
#			xhost +
#			xcompmgr -fF -I-.002 -O-.003 -D1 &
#			# TODO: choose a comp. manager...
#			compton &
#			### TODO: VB GA detection!?
#
#  			if [ -e "/etc/X11/Xsession.d/98vboxadd-xclient" ]; then 
#    				echo "Trying to run '/etc/X11/Xsession.d/98vboxadd-xclient'..."
#    				sudo sh /etc/X11/Xsession.d/98vboxadd-xclient 2>&1
#  			fi
					
			wait $PID
			exit 0
		fi
	done
	DISPLAY_NUM=$(( $DISPLAY_NUM + 1 ))
done

# no free display number found
exit 1
