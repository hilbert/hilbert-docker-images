#! /bin/bash

U=malex984
I=dockapp

#PP="$1"
#shift
#CH="$@"

# options for running terminal apps via docker run:
RUNTERM="-it --rm -a stdin -a stdout -a stderr"
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

docker run $RUNTERM --net=none \
   --name menu \
    "$U/$I:menu" $OPTS -- "/usr/local/bin/menu.sh" \
      "$@"
exit $?
# docker pause menu
# $OPTS -- /menu.sh

