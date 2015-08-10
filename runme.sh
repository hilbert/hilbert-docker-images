#! /bin/bash
set -e

XXX="" # 207 # prestart X11

OGL=(216 202 0)
### TODO: update OGL.tgz whenever we update :dummy
if [ -e /tmp/OGL.tgz ]; then 
  OGL=()
else
  if [ -e $HOME/OGL.tgz ]; then 
    cp $HOME/OGL.tgz /tmp/
    OGL=()
  fi
fi
  
U=malex984
I=dockapp
IM="$U/$I:main"

docker pull $IM

# HIP=$(ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print $2 }')
HIP=$(netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10)

echo
echo "Current Host ($HIP): `uname -a`"
echo "Current User: `id`"
echo "Please make sure that the current user is in docker group... "
echo "e.g. via 'sudo addgroup `whoami` docker'... " 


#USER_UID=$(id -u)
#set
#env
echo


XSOCK=/tmp/.X11-unix/
if [ ! -z "$XAUTHORITY" ]; then 
  export XAUTHORITY=/tmp/.docker.xauth
fi

X="XAUTHORITY"
case "$OSTYPE" in
 linux*) # For Linux host with X11:

    if [[ -d "$XSOCK" ]] && [[  "$DISPLAY" =~ ^:[0-9]+ ]]; then 
     echo "Forwarding X11 locally via xauth..."

     if [ ! -f $XAUTHORITY ]; then
        touch $XAUTHORITY
        xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTHORITY nmerge -
     fi
     echo "We now enable anyone to connect to this X11..."
     xhost +
     X="DISPLAY -e XAUTHORITY"
     XXX=""
   else
# Detect a Virtual Box VM!?
     echo "Please start one of X11 servers before using any GUI apps... "
#     X="NODISPLAY=1"
## TODO: start X11 server here??
   fi
 ;;

 darwin*) # our X11 host ip on Mac OS X via boot2docker:
  echo "TO BE TESTED!!!! Will probaby not work via Boot2Docker for now... Sorry! :("
  echo

  X="DISPLAY=192.168.59.3:0"
  ## $(boot2docker ip) ## ???
  echo "Please make sure to start xsocat.sh from your local X11 server since xeys's X-client will use '-e $X'..."
  echo "X11 should 'Allow connections from network clients & Your firewall should not block incomming connections to X11'"
#  # X11 instead of XQuartz? Xpara?
  open -a XQuartz # --args xterm $PWD/xsocat.sh #?
  XXX=""
 ;;
esac

echo "Will use the following X11 settings: "
echo "'$X'"

# pass CUPS_SERVER if previously set
if [ ! -z "$CUPS_SERVER" ]; then 
  X="$X -e CUPS_SERVER"
fi

export X

#    # Check if there is a container image with that name
#    if ! docker inspect --format '{{ .Author }}' "$1" >&/dev/null
#    then
#	echo "$0: $1: command not found"
#	return
#    fi
#    # Check that it's really the name of the image, not a prefix
#    if docker inspect --format '{{ .Id }}' "$1" | grep -q "^$1"
#    then
#	echo "$0: $1: command not found"
#	return
#    fi



#/etc/inittab

RET=0
myrunner () {
 ID=$(docker ps -a | grep "$IM" | awk '{ print $1 }')


#	-v /etc/passwd:/etc/passwd:ro \
#	-v /etc/shadow:/etc/shadow:ro \
#	-v /etc/group:/etc/group:ro \
#        -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d/:/etc/sudoers.d/:ro \
#	-v /home/:/home/:ro \
#	-v /dev/:/dev/:rw \
#	-v /var/:/var/:rw \
#	-v /run/:/run/:rw \
#       -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock 
 if [ -z $ID ]; then 
   # run --rm 
   ID=$(docker create -ti --privileged --net=host --ipc=host --pid=host \
        -p 631:631 -e HIP \
	-v /etc/localtime:/etc/localtime:ro \
        -v /dev:/dev:rw -v /tmp/:/tmp/:rw -v /run/udev:/run/udev -v /var/run/docker.sock:/var/run/docker.sock \
        -e $X \
	"$@" )
 fi
#      -v /sys/fs/cgroup:/sys/fs/cgroup:ro \


 docker start -ai $ID
 RET=$?

 docker stop -t 5 $ID > /dev/null 2>&1 
 docker rm -f $ID > /dev/null 2>&1 

# return $RET
}

# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v /var/run/docker.sock:/var/run/docker.sock \
# --add-host=dockerhost:$HIP --net host \ ## --net bridge \
# --name main $U/$I:main \
#   --no-kill-all-on-exit --skip-runit -- \
#      /usr/local/bin/main.sh "$@"
# /sbin/setuser ur /home/ur/bin/main.sh
##  /sbin/my_init --skip-startup-files --no-kill-all-on-exit --quiet --skip-runit \
# -e DOCKER_TLS_VERIFY=1 -e DOCKER_CERT_PATH=/home/ur/??? \

echo "Previously started containers: "
docker ps -a

# We expect this to run on Linux with docker confiured correctly
echo "Running the main glue script... "
echo

#-u $(whoami) -w "$HOME" \
#$(env | grep -v -E '^DISPLAY=' | cut -d= -f1 | awk '{print "-e", $1}') \

O="${OGL[@]}"
if [ ! -z "$O" ]; then 
  unset O
  echo "Run customizations (${OGL[@]})..."
  docker pull "$U/$I:dummy"
  myrunner "$IM" --no-kill-all-on-exit --skip-runit -- /usr/local/bin/main.sh ${OGL[@]}

  if [ -e /tmp/OGL.tgz ]; then 
    cp /tmp/OGL.tgz $HOME/
    OGL=()
  else
    echo "***** Sorry: customizations (${OGL[@]}) failed!"
    exit 1
  fi
fi  


ARGS=() #ARGS="$@"

if [ $# -gt 0 ]; then
  while [ ! -z "$1" ]; do
    ARGS=("${ARGS[@]}" "$1") # ARGS+=($1)
    if [ ! -z "$XXX" ]; then 
    if [ "x$1" = "x$XXX" ]; then
      XXX=""
    fi
    fi
    shift
  done
fi

if [ ! -z "$XXX" ]; then
  docker pull "$U/$I:x11"
  ARGS=("${ARGS[@]}" "$XXX") # ARGS+=($1)
fi


echo "Running :main with (${ARGS[@]})..."
# --name main 
myrunner "$IM" --no-kill-all-on-exit --skip-runit -- /usr/local/bin/main.sh "${ARGS[@]}"
#$ARGS
#    /sbin/setuser $(whoami) \



echo ".... Finished glue.... (exit code: $RET)"

# killing the gue if it still runs...
# echo
ID=$(docker ps -a | grep "$IM" | awk '{ print $1 }')

if [ ! -z $ID ]; then
  docker rm -f $ID # menu
fi

echo
echo "Leftover containers: "
docker ps -a
echo

exit $RET

