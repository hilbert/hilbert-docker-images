#! /bin/bash


APP="$1"

# USER_UID=$(id -u)

U=malex984
I=dockapp
#IMG="$U/$I:$APP"

ID=$(docker images | awk '{ print "[" $1 ":" $2 "]" }' | sort | uniq | grep "\[$APP\]" )

if [ ! -z "$ID" ]; then  
  IMG="$APP"
  APP=$(echo "$IMG" | sed 's@^.*:@@g')
  if [ "$APP" = "latest" ]; then
    APP=$(echo "$IMG" | sed -e 's@:.*$@@g' -e 's@/@_@g')  
  fi
else
  ID=$(docker images | awk '{ print "[" $1 "]" }' | sort | uniq | grep "\[$APP\]" )
  
  if [ ! -z "$ID" ]; then  
    IMG="$APP:latest"
  else
    IMG="$U/$I:$APP"
  fi  
fi

APP="c_$APP"

shift
ARGS="$@"

# XSOCK=/tmp/.X11-unix/

[ -z "$X" ] && X="DISPLAY"
X="$X -v /etc/localtime:/etc/localtime:ro -v /dev:/dev:rw -v /tmp/:/tmp/:rw -v /run/udev:/run/udev "

# -v /tmp:/tmp:rw \
# -v /run:/run:rw \
# -v /dev:/dev:rw \
# -v /var/log:/var/log:rw \
# -v /var/run:/var/run:rw \
# -v /etc/passwd:/etc/passwd:ro \
# -v /etc/shadow:/etc/shadow:ro \
# -v /etc/group:/etc/group:ro \
# -v /etc/localtime:/etc/localtime:ro \
# -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d/:/etc/sudoers.d/:ro \
# -v /home:/home:ro \
# -v /dev/dri:/dev/dri  -v /dev/input:/dev/input -v /run/udev:/run/udev \
# -v /tmp/.X11-unix:/tmp/.X11-unix \

### -v /var/:/var/:rw \
# -v /var/lib:/var/lib:rw \

## --device /dev/snd \


#        -v /etc/passwd:/etc/passwd:ro \
#        -v /etc/shadow:/etc/shadow:ro \
#        -v /etc/group:/etc/group:ro \
#        -v /etc/localtime:/etc/localtime:ro \
#        -v /home/:/home/:ro \
#        -v /var/:/var/:rw \
#        -v /run/:/run/:rw \
#        -v /sys/fs/cgroup:/sys/fs/cgroup:ro \


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

# USER_UID=$(id -u)
mydeamon () {
# -u $(whoami) -w "$HOME" \
# $(env | cut -d= -f1 | awk '{print "-e", $1}') \

# options for running terminal apps via docker run:
#  RUNTERM="--rm -it"

#        --lxc-conf='lxc.cgroup.devices.allow=c 195:* rwm' \
#        --lxc-conf='lxc.cgroup.devices.allow=c 249:* rwm' \
#	 --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
#        --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \
#        --lxc-conf='lxc.cgroup.devices.allow=c  81:* rwm' \

  R="--ipc=host --net=host --pid=host --privileged"

# -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri 

  docker run -d $R -P -e $X \
        "$@"

  RET="$?"

#  echo "Service ($APP) id: $ID"
#  docker start $ID

  exit $RET
}

# echo
# echo "Starting service $APP ('$ARGS')"

# 
OPTS="--skip-startup-files --quiet --skip-runit --no-kill-all-on-exit"
# --name $APP 

mydeamon --name "$APP" "$IMG" $OPTS -- $ARGS
# "/sbin/setuser" "ur" "..."?

