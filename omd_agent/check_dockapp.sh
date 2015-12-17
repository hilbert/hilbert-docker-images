#!/bin/bash

# Author: Oleksandr Motsak 
# Email: 
# License: MIT?
# Nagios Usage: check_nrpe!check_docker_top1/back/exited/foreign!cpu/mem/t/e/f/b
# Usage: check_dockapp_back.sh/check_dockapp_exited.sh/check_dockapp_foreign.sh/check_dockapp_top1.sh (link name)
#
# The script checks if a a single frontent container/app is running.
#   OK - running 0
#   WARNING - container is ghosted 1
#   CRITICAL - container is stopped 2
#   UNKNOWN - does not exist 3

function OK
{
  msg="$@"
  echo "OK - ${msg}"
  exit 0
}

function WARNING
{
  msg="$@"
  echo "WARNING - ${msg}"
  exit 1
}

function CRITICAL
{
  msg="$@"
  echo "CRITICAL - ${msg}"
  exit 2
}

function UNKNOWN
{
  msg="$@"
  echo "UNKNOWN - ${msg}"
  exit 3
}

function bashjoin
{ 
  local IFS="$1"
  shift
  echo "$*" 
}


#TOP=$(docker ps -a -q --filter "label=is_top_app=1" --filter "status=running" 2>/dev/null)
# --format="{{.ID}};{{.Image}};Status: {{.Status}}, Created: {{.CreatedAt}}, Running: {{.RunningFor}}"
# | sed 's!malex984/dockapp:!!g'



function res_usage0
{
  echo "cpu=0.00;;;0;100 mem=0.00;;;0;100"
}

function res_usage
{
  local IDS="$*"
  
  if [ -z "${IDS[@]}" ]; then
    res_usage0
  else  
    docker stats --no-stream ${IDS} \
    | tail -n +2 \
    | sed -e 's![%/]! !g' \
    | awk '{cpu+=$2;mem+=$7}END{printf "cpu=%2.2f;;;0;100 mem=%2.2f;;;0;100",cpu,mem}'
  fi
}


function check_dockapp_top1
{
MSG=($(docker ps -a -q \
 --filter "label=is_top_app=1" \
 --filter "status=running" \
 --format="{{.Image}}@[Status:{{.Status}},Created:{{.CreatedAt}}]&{{.ID}}" \
 2>/dev/null | sed -e 's!^malex984/dockapp:!!g' -e 's![ ]!_!g'))

if [ $? -ne 0 ]; then
  CRITICAL "cannot determine TOP app's info"
#  echo "CRITICAL - cannot determine TOP app"
#  exit 3
fi

N=${#MSG[@]}
# $(echo "${MSG[@]}" | wc -l)


if [ $N -eq 0 ]; then
#  N=0
  U=$(res_usage0)
  CRITICAL "no running TOP app! |t=$N;;;0; $U"
#  echo "UNKNOWN - not a single running TOP app!"
#  exit 3
fi
# echo $N

# MSG=("${MSG[0]}")
#local IFS=" ; "
#M=$(echo "${MSG[*]}" | xargs)

M=$(bashjoin '&' ${MSG[@]/&*/})
U=$(res_usage ${MSG[@]/*&/})

if [ $N -ne 1 ]; then
  WARNING "$N TOPs: $M|t=$N;;;0; $U"
#  echo "UNKNOWN - not a single running TOP app!"
#  exit 3
fi

OK "TOP: $M|t=$N;;;0; $U"
}







function check_dockapp_exited
{
MSG=($(docker ps -a -q \
 --filter "label=is_top_app" \
 --filter "status=exited" \
 --format="{{.Image}}@[Status:{{.Status}},Created:{{.CreatedAt}}]&{{.ID}}" \
 2>/dev/null | sed -e 's!^malex984/dockapp:!!g' -e 's![ ]!_!g'))

if [ $? -ne 0 ]; then
  CRITICAL "cannot determine docker ps info"
#  echo "CRITICAL - cannot determine TOP app"
#  exit 3
fi


N=${#MSG[@]}
# $(echo "${MSG[@]}" | wc -l)

#if [ -z "${MSG[@]}" ]; then
#  N=0
#fi

# echo "$N: ${MSG[@]} "

if [ $N -eq 0 ]; then
  U=$(res_usage0)
  OK "no exited apps/services!|e=$N;;;0; $U"
fi


#MSG=("${MSG[0]}")

#local IFS=" ; "
#M=$(echo "${MSG[*]}" | xargs)

#if [ $N -ne 1 ]; then
M=$(bashjoin '&' ${MSG[@]/&*/})
U=$(res_usage ${MSG[@]/*&/})

WARNING "$N exited apps/services: $M|e=$N;;;0; $U"
#  echo "UNKNOWN - not a single running TOP app!"
#  exit 3
#fi

}




function check_dockapp_back
{
MSG=($(docker ps -a -q \
 --filter "label=is_top_app=0" \
 --filter "status=running" \
 --format="{{.Image}}@[Status:{{.Status}},Created:{{.CreatedAt}}]&{{.ID}}" \
 2>/dev/null | sed -e 's!^malex984/dockapp:!!g' -e 's![ ]!_!g'))

if [ $? -ne 0 ]; then
  CRITICAL "cannot determine docker ps info"
#  echo "CRITICAL - cannot determine TOP app"
#  exit 3
fi

N=${#MSG[@]}
# $(echo "${MSG[@]}" | wc -l)

#if [ -z "${MSG[@]}" ]; then
#  OK "no running services!"
#  N=0
#fi

# echo "$N: ${MSG[@]} "

if [ $N -eq 0 ]; then
  U=$(res_usage0)
  OK "no running background services!|b=$N;;;0; $U"
fi


# MSG=("${MSG[0]}")
#local IFS=" ; "
# M=$(echo "${MSG[*]}" | xargs)

#if [ $N -ne 1 ]; then
#M=$(bashjoin '&' ${MSG[@]})
M=$(bashjoin '&' ${MSG[@]/&*/})
U=$(res_usage ${MSG[@]/*&/})

UNKNOWN "$N running service(s): $M|b=$N;;;0; $U"
#  echo "UNKNOWN - not a single running TOP app!"
#  exit 3
#fi
}





function check_dockapp_foreign
{

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT INT TERM HUP

# --format="{{.Image}} @ [Status: {{.Status}}, Created: {{.CreatedAt}}]" 
docker ps -a -q                               2>/dev/null | sort > "$tmpdir/all"
if [ $? -ne 0 ]; then
  CRITICAL "cannot determine docker ps info"
fi

# --format="{{.Image}} @ [Status: {{.Status}}, Created: {{.CreatedAt}}]" 
docker ps -a -q --filter "label=is_top_app"   2>/dev/null | sort > "$tmpdir/my"
if [ $? -ne 0 ]; then
  CRITICAL "cannot determine docker ps info"
fi

#ls -la $tmpdir/*
#cat $tmpdir/*

#comm "$tmpdir/all" "$tmpdir/my"

# unique to all (i.e. not in my)
MSG=($(comm -23 "$tmpdir/all" "$tmpdir/my" 2>/dev/null))

if [ $? -ne 0 ]; then
  CRITICAL "cannot determine foreign containers via 'comm'"
fi


# MSG=$(cat  "$tmpdir/other" 2>/dev/null)

N=${#MSG[*]}
#  $(echo "${MSG[@]}" | wc -l)

#if [ -z "${MSG[@]}" ]; then
#  N=0
#fi

# echo "$N: ${MSG[@]}"

if [ $N -eq 0 ]; then
  U=$(res_usage0)
  OK "no foreign docker containers present!|f=$N;;;0; $U"
fi



## TODO: !
U=$(res_usage ${MSG[*]})

#  ${!arr[*]}
for ind in ${!MSG[*]}
do
#  echo "$ind : ${MSG[$ind]}"
  MSG[$ind]=$(docker ps -a -q --filter "id=${MSG[$ind]}" --format="{{.Image}}@[Status:{{.Status}},Created:{{.CreatedAt}}]" 2>/dev/null | sed -e 's![ ]!_!g')
  if [ $? -ne 0 ]; then
    CRITICAL "cannot determine docker ps info"
  fi
done
#MSG=("${MSG[0]}")
#local IFS=" ; "

# M=$(echo "${MSG[*]}" | xargs)

#if [ $N -ne 1 ]; then

M=$(bashjoin '&' ${MSG[@]})

WARNING "$N foreign container(s) present: $M|f=$N;;;0; $U"
}


function check_dockapp_heartbeat
{

HOST_NAME=localhost
PORT_NUMBER=8080


S=`curl -s -X GET "http://${HOST_NAME}:${PORT_NUMBER}/status" 2>&1`

case "$S" in
OK*)
echo "$S"; exit 0;;
WARNING*)
echo "$S"; exit 1;;
CRITICAL*)
echo "$S"; exit 2;;
esac

echo "$S"; exit 3

}


CMD=$(basename "$0" '.sh' | grep -E '^check_dockapp_')
if [ $? -ne 0 ]; then
  CRITICAL "wrong command: '$0'"
fi

# echo "CMD: [$CMD]"

$CMD

# check_dockapp_foreign
# check_dockapp_back
# check_dockapp_exited
# check_dockapp_top1

CRITICAL "something went wrong..."

exit 0


# mkfifo "$tmpdir/pipe"

# docker ps -a -q --filter "label=is_top_app=0" 2>/dev/null | sort > "$tmpdir/sv"


RUNNING=$(docker inspect --format="{{.Config.Image}} {{.State.Status}}" $CONTAINER 2> /dev/null)



# (created|restarting|running|paused|exited)

if [ "$RUNNING" != "running" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

GHOST=$(docker inspect --format="{{ .State.Dead }}" $CONTAINER)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

# NETWORK=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER)

# docker stats --no-stream $CONTAINER
# IP: $NETWORK, 
STARTED=$(docker inspect --format="{{ .State.StartedAt }}" $CONTAINER)
echo "OK - $CONTAINER is running. StartedAt: $STARTED"





exit 0




#!/bin/bash
DIRS="/var/log /tmp"

for dir in $DIRS
do
    count=$(ls $dir | wc --lines)
    if [ $count -lt 50 ] ; then
        status=0
        statustxt=OK
    elif [ $count -lt 100 ] ; then
        status=1
        statustxt=WARNING
    else
        status=2
        statustxt=CRITICAL
    fi
    echo "$status Filecount_$dir count=$count;50;100;0; $statustxt - $count files in $dir"
done



exit 0


# docker ps --format "{{.ID}}: {{.Command}}"
.ID
Container ID
.Image
Image ID
.Command  
Quoted command
.CreatedAt
Time when the container was created.
.RunningFor
Elapsed time since the container was started.
.Ports
Exposed ports.
.Status
Container status.
.Size
Container disk size. ???? 0 B??!!!
.Names
Container names.
.Labels
All labels assigned to the container.
.Label
Value of a specific label for this container. For example {{.Label "com.docker.swarm.cpu"}}


## Filtering
The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

The currently supported filters are:

id 
(container’s id)

label 
(label=<key> or label=<key>=<value>)

name 
(container’s name)

exited 
(int - the code of exited containers. Only useful with --all)

status 
(created|restarting|running|paused|exited)

ancestor 
(<image-name>[:<tag>], <image id> or <image@digest>) - filters containers that were created from the given image or a descendant.

