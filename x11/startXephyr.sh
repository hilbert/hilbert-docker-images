#!/bin/bash

F="$1"
shift

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


	Xephyr :$DISPLAY_NUM $@ & 2> /dev/null
	PID=$!
	# while Xephyr is still running
	while ps -o pid | grep -q "^[[:space:]]*"$PID"[[:space:]]*$"
	do
		sleep 0.1
		# test if it aquired the X11 lock file
		if grep -q "^[[:space:]]*"$PID"[[:space:]]*$" `find /tmp/ | grep "^/tmp/\.X"$DISPLAY_NUM"-lock$"`
		then
			# write the display number to the log file
			echo $DISPLAY_NUM > "$F"
			wait $PID
			exit 0
		fi
	done
	DISPLAY_NUM=$(( $DISPLAY_NUM + 1 ))
done

# no free display number found
exit 1
