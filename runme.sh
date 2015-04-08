#! /bin/bash
set -e

U=malex984
I=dockapp
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


export XSOCK=/tmp/.X11-unix/
export X="DISPLAY=:0 -v $XSOCK:$XSOCK"

case "x$OSTYPE" in
 linux*) # For Linux host with X11:

   if  [ "x$DISPLAY" != "x:0" ]; then
     echo "Forwarding X11 via xauth..."
     export XAUTH=/tmp/.docker.xauth

     if [ ! -f $XAUTH ]; then
        touch $XAUTH
        xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge -
     fi
     echo "We now enable anyone to connect to this X11..."
     xhost +
     export X="$X -e USER -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH"
   elif [ "x$DISPLAY" == "x:0" -o -d "$XSOCK" ]; then
     echo "Just Forwarding X11 socket locally... "
     export X="DISPLAY=:0 -v $XSOCK:$XSOCK"
   else
# Detect a Virtual Box VM!?
#     export X="DISPLAY=:0 -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH"
     echo "Please start one of X11 servers before using any GUI apps... "
     export X="NODISPLAY=1"
## TODO: start X11 server here??
   fi
 ;;

 darwin*) # our X11 host ip on Mac OS X via boot2docker:
  echo "TO BE TESTED!!!! Will probaby not work via Boot2Docker for now... Sorry! :("
  echo

  export X="DISPLAY=192.168.59.3:0"
  ## $(boot2docker ip) ## ???
  echo "Please make sure to start xsocat.sh from your local X11 server since xeys's X-client will use '-e $X'..."
  echo "X11 should 'Allow connections from network clients & Your firewall should not block incomming connections to X11'"
#  # X11 instead of XQuartz? Xpara?
  open -a XQuartz # --args xterm $PWD/xsocat.sh #?
 ;;
esac


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

myrunner () {
#        -u $(whoami) -w "$HOME" \
#	$(env | cut -d= -f1 | awk '{print "-e", $1}') \
  sudo docker run -ti --net bridge --privileged \
        --add-host=dockerhost:$HIP \
        -e $X \
        -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/shadow:/etc/shadow:ro \
	-v /etc/group:/etc/group:ro \
	-v /etc/localtime:/etc/localtime:ro \
	-v /dev/:/dev/ \
        -v /tmp/:/tmp/ \
	-v /var/:/var/ \
	-v /run/:/run/ \
	-v /home/:/home/ \
	"$@"
}
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v /var/run/docker.sock:/var/run/docker.sock \
## --restart=always \
# --add-host=dockerhost:$HIP --net host \ ## --net bridge \
# --name main $U/$I:main \
#   --no-kill-all-on-exit --skip-runit -- \
#      /usr/local/bin/main.sh "$@"
# /sbin/setuser ur /home/ur/bin/main.sh
##  /sbin/my_init --skip-startup-files --no-kill-all-on-exit --quiet --skip-runit \
# -e DOCKER_TLS_VERIFY=1 -e DOCKER_CERT_PATH=/home/ur/??? \

echo "Previously started containers: "
sudo docker ps -a

# We expect this to run on Linux with docker confiured correctly
echo "Running the main glue script... "
echo
myrunner \
 --name main $U/$I:main \
   --no-kill-all-on-exit --skip-runit -- \
      /usr/local/bin/main.sh "$@"

echo ".... Finished glue.... (exit code: $?)"

# killing the gue if it still runs...
echo
sudo docker rm -f main # menu

echo
echo "Leftover containers: "
sudo docker ps -a
echo

exit 0
