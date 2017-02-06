#! /bin/bash

# USER_UID=$(id -u)
APP="$1"

shift
ARGS="$@"


# The following is an adaptation to the new naming schema: hilbert/$APP:$VERSION
U=hilbert
IMAGE_VERSION="${IMAGE_VERSION:-latest}"
IMG="$U/${APP}:${IMAGE_VERSION}" # IMG="$APP" #IMG="$U/$I:$APP"

ID=$(docker images | awk '{ print "[" $1 ":" $2 "]" }' | sort | uniq | grep "\[${IMG}\]")

if [ -z "$ID" ]; then
  echo "ERROR: no such image '${IMG}'"
  exit 2
fi

APP="c_$APP"

  echo
  echo "Starting '$IMG' with [$ARGS] under the name '$APP'"


#XSOCK=/tmp/.X11-unix/
#[ -z "$X" ] && X="DISPLAY -e XAUTHORITY"

# pass CUPS_SERVER if previously set
#if [ ! -z "$CUPS_SERVER" ]; then
#  X="$X -e CUPS_SERVER"
#fi 

# -v /tmp/:/tmp/ \
#        -v /etc/machine-id:/etc/machine-id:ro \
#  -v /dev/dri:/dev/dri \
#  -v /dev/shm:/dev/shm \
#  --device=/dev/video0:/dev/video0 \
#  -v /dev/snd:/dev/snd \

## -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
# -v /var/lib:/var/lib:rw \
X="$X \
 -v /etc/localtime:/etc/localtime:ro \
 -v /dev:/dev:rw -v /tmp/:/tmp/:rw -v /run/udev:/run/udev \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
 -v /run/systemd:/run/systemd \
 -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
"
#  -p 631:631 -p 5900:5900 \

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


# --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm \

# options for running terminal apps via docker run:
# -P
RUNTERM="-a stdout -a stderr --net=host --ipc=host --label is_top_app=1"
OPTS="--skip-startup-files --quiet --skip-runit"

#      --lxc-conf='lxc.cgroup.devices.allow=c 195:* rwm' \
#     --lxc-conf='lxc.cgroup.devices.allow=c 249:* rwm' \
#     --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
#     --lxc-conf='lxc.cgroup.devices.allow=c 81:* rwm' \
#     --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \

# run --rm
ID=$(docker create \
     $RUNTERM --name "$APP" \
     -e $X \
        "$IMG" $OPTS -- \
		$ARGS )
#            /sbin/setuser $(whoami) \

docker start -ai "$ID"
RET=$?

docker stop -t 5 "$ID"
#> /dev/null 2>&1
docker rm -f "$ID"
#> /dev/null 2>&1 

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

