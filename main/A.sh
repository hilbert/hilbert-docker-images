#! /bin/bash

U=malex984
I=dockapp

# options for running terminal apps via docker run:
RUNTERM="-it --rm -a stdin -a stdout -a stderr"
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

docker run $RUNTERM --net=none --name appa "$U/$I:appa" $OPTS -- "/usr/local/bin/A.sh" "$@"

