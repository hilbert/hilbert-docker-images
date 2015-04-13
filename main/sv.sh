#! /bin/bash

U=malex984
I=dockapp

USER_UID=$(id -u)

APP="$1"
shift
ARGS="$@"

XSOCK=/tmp/.X11-unix/
[ -z "$X" ] && X="NODISPLAY=1"

X="$X \
        -v /tmp/:/tmp/ \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v /dev/:/dev/ \
        -v /var/:/var/ \
        -v /run/:/run/ \
        -v /home/:/home/ \
        -v /sys/fs/cgroup:/sys/fs/cgroup \
"

# USER_UID=$(id -u)
mydeamon () {
# -u $(whoami) -w "$HOME" \
# $(env | cut -d= -f1 | awk '{print "-e", $1}') \

# options for running terminal apps via docker run:
  RUNTERM="-d" # " --rm -it "

  ID=$(sudo docker create $RUNTERM --privileged --net host --ipc=host --pid=host -P -e $X \
        --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
        --lxc-conf='lxc.cgroup.devices.allow=c 81:* rwm' \
        --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \
        "$@")
  echo "Service ($APP) id: $ID"

  docker start $ID
  RET="$?"

  exit $RET
}
#        -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock \
#        -e CUPS_USER_ADMIN=vagrant -e CUPS_USER_PASSWORD=vagrant -p 6631:631/tcp \
# -v /var/run/docker.sock:/var/run/docker.sock \
#XSOCK=/tmp/.X11-unix/ # XAUTH??
# -v /tmp/.X11-unix:/tmp/.X11-unix \
#SND="$XSOCK:$XSOCK \
# -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
# -v /run/udev:/run/udev \
# -v /var/lib/dbus:/var/lib/dbus \
# -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
# --device=/dev/video0:/dev/video0 \
# -v /dev/dri/:/dev/dri/ \
# -v /dev/input/:/dev/input/ \
# -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
# -v /dev/snd:/dev/snd \
# -v /home/vagrant:/home/docker \
# -v /dev/shm:/dev/shm #??
# -v /run/user/${USER_UID}/pulse:/run/user/${USER_UID}/pulse \
# -e PULSE_SERVER=/run/user/${USER_UID}/pulse/native "
# -v /run/user/${USER_UID}/pulse:/run/pulse \
## --restart=always \
# --add-host=dockerhost:$HIP --net host \ ## --net bridge \
# --name main $U/$I:main \
#   --no-kill-all-on-exit --skip-runit -- \
#      /usr/local/bin/main.sh "$@"
# /sbin/setuser ur /home/ur/bin/main.sh
##  /sbin/my_init --skip-startup-files --no-kill-all-on-exit --quiet --skip-runit \
# -e DOCKER_TLS_VERIFY=1 -e DOCKER_CERT_PATH=/home/ur/??? \

echo
echo "Starting service $APP ('$ARGS')"

OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"
# --name $APP 

mydeamon "$U/$I:$APP" $OPTS -- $ARGS # "/sbin/setuser" "ur" "..."?

