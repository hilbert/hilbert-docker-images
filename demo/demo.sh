#! /bin/bash

ARGS=() #ARGS="$@"

if [ $# -gt 0 ]; then
  while [ "$1" != "" ]; do
    ARGS=("${ARGS[@]}" "$1") # ARGS+=($1)
    shift
  done
fi

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

U=malex984
I=dockapp
#
PREFIX="$U/$I"

if [ -z "$HIP" ]; then 
  HIP=$(ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print $2 }')
  # HIP=$(netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10)
  export HIP
fi

echo
echo "Current System: `uname -a` (HOST IP: $HIP)"
echo "Current User: `id`"
#USER_UID=$(id -u)
#set
#env

echo
ls -al /dev/ptmx
ls -al /dev/pts/ptmx
df -h


XSOCK=/tmp/.X11-unix/
#X="XAUTHORITY"

if [ ! -z "$XAUTHORITY" ]; then 
  export XAUTHORITY=/tmp/.docker.xauth
fi

case "$OSTYPE" in
 linux*) # For Linux host with X11:

   if [[ -d "$XSOCK" ]] && [[  "$DISPLAY" =~ ^:[0-9]+ ]]; then
     echo "Forwarding X11 via xauth..."

     if [ ! -f $XAUTHORITY ]; then
        touch $XAUTHORITY
        xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTHORITY nmerge -
     fi
     echo "We now enable anyone to connect to this X11..."
     xhost +
#     xcompmgr &
#     compton &
     # X="DISPLAY -e XAUTHORITY"
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

  export DISPLAY="192.168.59.3:0"
#  export X="DISPLAY"
  ## $(boot2docker ip) ## ???
  echo "Please make sure to start xsocat.sh from your local X11 server since xeys's X-client will use '-e $X'..."
  echo "X11 should 'Allow connections from network clients & Your firewall should not block incomming connections to X11'"
#  # X11 instead of XQuartz? Xpara?
  open -a XQuartz # --args xterm $PWD/xsocat.sh #?
 ;;
esac

#echo "Will use the following X11 settings: "
#echo "'$X'"
#
# pass CUPS_SERVER if previously set
#if [ ! -z "$CUPS_SERVER" ]; then
#  X="$X -e CUPS_SERVER"
#fi 
#
#export X

echo "Current docker images: "
docker images

echo "Current docker containers: "
docker ps -a
echo


## options for /sbin/my_init:
#OPTS="--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit"
## options for running terminal apps via docker run:
#RUNTERM="--rm -it  -a stdin -a stdout -a stderr"

echo
echo "This is the DEMO loop running on ${HOSTNAME}:"
# uname -a

### Handle all possible settings

if [ -r $SELFDIR/settings ]; then
  source $SELFDIR/settings
fi

while :
do
 mygetenv
 
 echo "Current X: [$X]"
 echo "_____ XID: [$XID]"

 ### TODO: CHECK FOR X11 OR MAKE SURE XID & DISPLAY ARE VALID!

 ### TODO: add a choice to go to text mode!!!!
 
 echo "Current ARGS: ${ARGS[@]}"
 
 if [ ${#ARGS[@]} -eq 0 ]; then
   $SELFDIR/menu.sh \
     "Your choice please?" 300 " Surfer GPU_Test Iceweasel Kiosk_index Kiosk_at_localhost Kivy Kivy_Deflectouch Skype Media_Players Q3 "
   ARGS=("$?")
 fi
 
 echo "Current command(s) to be processed first: ${ARGS[@]}"

 APP="${ARGS[0]}" # get 1st  array element
 ARGS=("${ARGS[@]:1}") # remove it from array

 echo "Processing command '$APP'..."

 case "$APP" in
    300) # Surfer
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting GUI shell for surfer... Please build surfer yourself... " 
	$SELFDIR/run.sh "surfer" launch.sh /opt/SURFER/SURFER
	# /opt/SURFER/SURFER
#	$SELFDIR/run.sh "$PREFIX:appchoo" bash
        # "rxvt-unicode -fn xft:terminus:pixelsize=12 -e bash"
      else
        echo "Please start X11 beforehand!"
      fi
    ;;
    
    301) # GPU Test 
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting GUI shell for test... Please build test yourself... " && $SELFDIR/run.sh 'test' launch.sh
	# "rxvt-unicode -fn xft:terminus:pixelsize=12 -e bash" ## xterm?
      else
        echo "Please start X11 beforehand!"
      fi
    ;;
    
    302) # FireFox
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting iceweasel/firefox?... "
	$SELFDIR/run.sh "iceweasel" firefox
      else
        echo "Please start X11 beforehand!"
      fi
    ;;

    303) # Kiosk with its index.html
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting Kiosk-Mode WebBrowser for DEMO... " && $SELFDIR/run.sh 'kiosk' launch.sh \
             /usr/local/src/kiosk/run.sh
	# /usr/local/src/kiosk/run.sh
	#  /usr/lib/node_modules/kiosk/run.sh
	# "rxvt-unicode -fn xft:terminus:pixelsize=12 -e bash" ## xterm?
      else
        echo "Please start X11 beforehand!"
      fi
    ;;
    
    304) # Kiosk using http://localhost:8080    
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting Kiosk-Mode WebBrowser for DEMO... " && $SELFDIR/run.sh 'kiosk' launch.sh \
             /usr/local/src/kiosk/run.sh -l "http://localhost:8080/"
	# /usr/local/src/kiosk/run.sh
	#  /usr/lib/node_modules/kiosk/run.sh
	# "rxvt-unicode -fn xft:terminus:pixelsize=12 -e bash" ## xterm?
      else
        echo "Please start X11 beforehand!"
      fi
    ;;
    
    305) # Kivy
      if [ ! -z "$DISPLAY" ]; then
        echo "Start some kivy app in MT-Mode... " && $SELFDIR/run.sh 'kivy' launch.sh
      else
        echo "Please start X11 beforehand!"
      fi
    ;;

    306) # Kivy with Deflectouch
      if [ ! -z "$DISPLAY" ]; then
        echo "Start gravity-pong_v0.1.9a in MT-Mode... " && $SELFDIR/run.sh 'kivy' bash -c 'setup_ogl.sh && cd /usr/local/src/Deflectouch/ && python main.py'
      else
        echo "Please start X11 beforehand!"
      fi
    ;;

    307) # Skype
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting skype... " && $SELFDIR/run.sh "skype" skype.sh
      else
        echo "Please start X11 beforehand!"
      fi
    ;;

    308) Media Players...
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting GUI shell... Please run cmus/vlc/mplaye/xine yourself... " && $SELFDIR/run.sh "play" launch.sh
        # "rxvt-unicode -fn xft:terminus:pixelsize=12 -e bash"
      else
        echo "Please start X11 beforehand!"
      fi
    ;;


    309) # Q3: openarena
      if [ ! -z "$DISPLAY" ]; then
        echo "Starting Q3... "
 	$SELFDIR/run.sh "q3" bash -c "setup_ogl.sh;/usr/games/openarena"
	#/usr/games/openarena
      else
        echo "Please start X11 beforehand!"
      fi
    ;;

    ########### add new things here ############
    # ...
    ############################################
    
    *)
      echo
      echo "Thank You!"
      echo
      echo "Quiting... please make sure to kill any services yourself... "
      
      if [ ! -z "$XID" ]; then
        echo "Don't forget to kill X11 docker container: $XID"
        echo "DISPLAY: $DISPLAY"
####        docker rm -vf $XID #### TODO: GRACEFULL X11 SHUTDOWN???
      fi
      echo "Leftover containers: "
      docker ps -a
   
      ls -al /dev/ptmx
      ls -al /dev/pts/ptmx
      df -h
      
      exit 0
    ;;
  esac

  RET="$?"  
  echo "Exit code was: [$RET]"
  echo "And now back to the choice..."
  
  ls -al /dev/ptmx
  ls -al /dev/pts/ptmx
  df -h  
done




################ TODO: don't mount all of /dev/! Try to make use of the necessary devices only!

# -v /dev/shm:/dev/shm \
# -v /etc/machine-id:/etc/machine-id \
# -v /var/lib/dbus:/var/lib/dbus \
# -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket \
# -v /var/run/docker.sock:/var/run/docker.sock \
# -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock \
# -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
# -v /sys/fs/cgroup:/sys/fs/cgroup \
# -v /run/user/${USER_UID}/pulse:/run/user/${USER_UID}/pulse \
# -v /run/user/${USER_UID}/pulse:/run/pulse \
# -v /home/vagrant:/home/docker \
# -v /dev/dri:/dev/dri \
# --device=/dev/video0:/dev/video0 \
# -v /dev/snd:/dev/snd "
# -e PULSE_SERVER=/run/user/${USER_UID}/pulse/native \
#      docker run -it --name sound \
#        --privileged \
#       -e $SND \
#       --lxc-conf='lxc.cgroup.devices.allow=c 226:* rwm' \
#       --lxc-conf='lxc.cgroup.devices.allow=c 81:* rwm' \
#       --lxc-conf='lxc.cgroup.devices.allow=c 116:* rwm' \
#      "$U/$I:sound" /sbin/setuser ur /bin/bash

#echo "Pulling necessary images: "
#docker pull "$U/$I:base"
#docker pull "$U/$I:dd"
#docker pull "$U/$I:main"
#docker pull "$U/$I:menu"
#docker pull "$U/$I:appa"
#docker pull "$U/$I:alsa"
#docker pull "$U/$I:xeyes"
#docker pull "$U/$I:gui"
#docker pull "$U/$I:x11"
#docker pull "$U/$I:skype"
#docker pull "$U/$I:q3"
#docker pull "$U/$I:iceweasel"
#docker pull "$U/$I:cups"
