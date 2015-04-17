#! /bin/bash

U=malex984
I=dockapp

USER_UID=$(id -u)
APP="$1"
shift
ARGS="$@"

  echo
  echo "Starting $APP ('$ARGS')"

XSOCK=/tmp/.X11-unix/
[ -z "$X" ] && X="NODISPLAY=1"

# -v /tmp/:/tmp/ \
#        -v /etc/machine-id:/etc/machine-id:ro \
#  -v /dev/dri:/dev/dri \
#  -v /dev/shm:/dev/shm \
#  --device=/dev/video0:/dev/video0 \
#  -v /dev/snd:/dev/snd \

X="$X \
 -v /tmp/:/tmp/ \
 -v /etc/passwd:/etc/passwd:ro \
 -v /etc/shadow:/etc/shadow:ro \
 -v /etc/group:/etc/group:ro \
 -v /etc/localtime:/etc/localtime:ro \
 -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d/:/etc/sudoers.d/:ro \
 -v /home/:/home/ \
 -v /var/lib/dbus:/var/lib/dbus \
 -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
 -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
 -v /sys/fs/cgroup:/sys/fs/cgroup \
 -v /dev/:/dev/ \
"

# options for running terminal apps via docker run:
RUNTERM="-it -a stdin -a stdout -a stderr --net host --privileged --ipc=host --pid=host "
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

# run --rm
ID=$(docker create \
     $RUNTERM \
     -e $X \
     --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
     --lxc-conf='lxc.cgroup.devices.allow=c 81:* rwm' \
     --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \
        "$U/$I:$APP" $OPTS -- \
		$ARGS )
#            /sbin/setuser $(whoami) \

docker start -ai $ID
RET=$?

docker stop -t 5 $ID > /dev/null 2>&1
docker rm -f $ID > /dev/null 2>&1 

exit $RET

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

