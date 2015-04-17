#! /bin/bash
set -e

U=malex984
I=dockapp
IM="$U/$I:main"
HIP=`ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print \$2 }'`

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
X="NODISPLAY=1"
case "$OSTYPE" in
 linux*) # For Linux host with X11:

    if [[ -d "$XSOCK" ]] && [[  "$DISPLAY" =~ ^:[0-9]+ ]]; then 
     echo "Forwarding X11 locally via xauth..."
     XAUTH=/tmp/.docker.xauth

     if [ ! -f $XAUTH ]; then
        touch $XAUTH
        xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge -
     fi
     echo "We now enable anyone to connect to this X11..."
     xhost +
     X="DISPLAY -e XAUTHORITY=$XAUTH"
   else
# Detect a Virtual Box VM!?
     echo "Please start one of X11 servers before using any GUI apps... "
     X="NODISPLAY=1"
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
 ;;
esac

echo "Will use the following X11 settings: "
echo "'$X'"

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

RET=0
myrunner () {
 ID=$(docker ps -a | grep "$IM" | awk '{ print $1 }')

 if [ -z $ID ]; then 
   # run --rm 
   ID=$(docker create -ti --net host --privileged --ipc=host --pid=host \
        --add-host=dockerhost:$HIP \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/shadow:/etc/shadow:ro \
	-v /etc/group:/etc/group:ro \
	-v /etc/localtime:/etc/localtime:ro \
        -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d/:/etc/sudoers.d/:ro \
	-v /home/:/home/:ro \
        -v /tmp/:/tmp/:rw \
        -e $X -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock \
	-v /dev/:/dev/:rw \
	-v /var/:/var/:rw \
	-v /run/:/run/:rw \
	"$@" )
 fi

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
 
# --name main 
myrunner "$IM" --no-kill-all-on-exit --skip-runit -- /usr/local/bin/main.sh "$@"
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

