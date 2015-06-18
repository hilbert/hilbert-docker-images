#! /bin/bash

# USER_UID=$(id -u)
APP="$1"
shift
ARGS="$@"

U=malex984
I=dockapp


## full image name?
ID=$(docker images | awk '{ print "[" $1 ":" $2 "]" }' | sort | uniq | grep "\[$APP\]" )

# yes?
if [ ! -z "$ID" ]; then  
  IMG="$APP"
  APP=$(echo "$IMG" | sed 's@^.*:@@g')  
  if [ "$APP" = "latest" ]; then
    APP=$(echo "$IMG" | sed -e 's@:.*$@@g' -e 's@/@_@g')  
  fi
else
# short local image name?
  ID=$(docker images | awk '{ print "[" $1 "]" }' | sort | uniq | grep "\[$APP\]" )
  
  # yes?
  if [ ! -z "$ID" ]; then  
    IMG="$APP:latest"
  else
    # no?
    
    TAG=$(echo "$APP" | sed 's@^.*/.*:@@g')
    
    if [ "x$APP" = "x$TAG" ]; then 
      # missing prefix for a missing standard image
      IMG="$U/$I:$TAG"
    else
      # is it a full name for a missing image?
      IMG="$APP"
      APP="$TAG"
    fi  
    unset TAG
  fi  
fi

APP="c_$APP"

  echo
  echo "Starting '$IMG' ('$ARGS') under the name '$APP'"


XSOCK=/tmp/.X11-unix/
[ -z "$X" ] && X="DISPLAY -e XAUTHORITY"

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
 -v /dev:/dev:rw -v /tmp/:/tmp/:rw -v /run/udev:/run/udev
"

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
RUNTERM="-it -a stdin -a stdout -a stderr --privileged --net=host --ipc=host --pid=host"
OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"

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

