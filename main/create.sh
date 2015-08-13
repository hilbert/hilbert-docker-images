#! /bin/bash

APP="$1"
shift
ARGS="$@"
##  echo "Creating $IMG for running '$ARGS'"

IMG="$APP"

#U=malex984
#I=dockapp
#IMG="$U/$I:$APP"

[ -z "$X" ] && X="NOX" 
# " -v /tmp/:/tmp/:rw -v /dev/:/dev/:rw "

# -v /etc/machine-id:/etc/machine-id:ro \
# -v /etc/passwd:/etc/passwd:ro \
# -v /etc/shadow:/etc/shadow:ro \
# -v /etc/group:/etc/group:ro \
# -v /etc/localtime:/etc/localtime:ro \
# -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d/:/etc/sudoers.d/:ro \
# -v /home/:/home/:ro \
# -v /var/lib/dbus:/var/lib/dbus \
# -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
# -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
# -v /sys/fs/cgroup:/sys/fs/cgroup:ro \

# options for running terminal apps via docker run:
RUNTERM="-it -a stdin -a stdout -a stderr --privileged --net=host --ipc=host --pid=host"
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

# $RUNTERM --net=none --name appa "$U/$I:appa" $OPTS -- "/sbin/setuser" "ur" "/home/ur/bin/A.sh" "$@"
# -- /bin/bash $ARGS
docker create $RUNTERM -e $X "$IMG" $OPTS -- $ARGS






