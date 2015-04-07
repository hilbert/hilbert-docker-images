#! /bin/bash

U=malex984
I=dockapp

USER_UID=$(id -u)
APP="$1"
shift
ARGS="$@"

  echo
  echo "Starting $APP ('$ARGS')"

[ -z "$X" ] && X="DISPLAY=:0"

X="$X \
 -v /tmp/:/tmp/ \
 -v /etc/machine-id:/etc/machine-id \
 -v /var/lib/dbus:/var/lib/dbus \
 -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
 -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
 -v /sys/fs/cgroup:/sys/fs/cgroup \
 -v /dev/dri:/dev/dri \
 --device=/dev/video0:/dev/video0 \
 -v /dev/snd:/dev/snd \
"
# options for running terminal apps via docker run:
RUNTERM="-it --rm -a stdin -a stdout -a stderr --net bridge --privileged"
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

sudo docker run \
     $RUNTERM \
     -e $X \
     --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
     --lxc-conf='lxc.cgroup.devices.allow=c 81:* rwm' \
     --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \
     --name $APP "$U/$I:$APP" $OPTS -- $ARGS

exit $?

# $RUNTERM --net=none --name appa "$U/$I:appa" $OPTS -- "/sbin/setuser" "ur" "/home/ur/bin/A.sh" "$@"
# -- /bin/bash $ARGS
### "/sbin/setuser" "ur" 

# localhost # this does not work :(
# -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
# -v /dev/shm:/dev/shm \
# -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock \
# -v /var/run/docker.sock:/var/run/docker.sock \
# -v /home/vagrant:/home/docker \
# -v /run/user/${USER_UID}/pulse:/run/user/${USER_UID}/pulse \
# -e PULSE_SERVER=/run/user/${USER_UID}/pulse/native "
# -v /run/user/${USER_UID}/pulse:/run/pulse \

