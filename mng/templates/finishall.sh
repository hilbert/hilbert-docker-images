#!/bin/sh

set -v
set -x

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`
cd "${SELFDIR}/"

## set -e
# unset DISPLAY

if [ -r "./station.cfg" ]; then
    . "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    . "./startup.cfg"
fi

#if [ -r "./docker.cfg" ]; then
#    . "./docker.cfg"
#fi

#if [ -r "./compose.cfg" ]; then
#    . "./compose.cfg"
#fi


#   export current_app="${default_app}"
#   echo "export current_app='${current_app}'" > "/tmp/lastapp.cfg.new~"

if [ -r "/tmp/lastapp.cfg" ]; then
    . "/tmp/lastapp.cfg"
    
    d="${current_app}"
    :
else
    d="${default_app}"
    :
fi

if [ -r "./docker.cfg" ]; then
    . "./docker.cfg"
fi

if [ -n "${COMPOSE_FILE}" ]; then
  F="plain.${COMPOSE_FILE}"
  rm -f "$F"
  "./luncher.sh" config > "$F"
  export COMPOSE_FILE="$F"
fi



#ip link add dummy0 type dummy >/dev/null 2>&1 
#if [[ $? -eq 0 ]]; then
#  # clean the dummy0 link
#  ip link delete dummy0 >/dev/null 2>&1
#  PRIVILEGED=*
#else
#  PRIVILEGED=
#fi
		
if [ -n "$d" ]; then
    echo "Stop/kill/rm FG GUI App: '$d'..."

    "./luncher.sh" stop -t 10 "$d"
    "./luncher.sh" kill -s SIGTERM "$d"
    "./luncher.sh" kill -s SIGKILL "$d"
    "./luncher.sh" rm -f "$d"
fi



## TODO: FIXME: in reversed order!?
for d in ${background_services}; do
  #! Exclude Monitoring agent (for now) 
  if [ ! "x$d" = "xomd_agent" ]; then  
    echo "Stop/kill/rm BG Service: '$d'..."
    "./luncher.sh" stop -t 10 "$d"
    "./luncher.sh" kill -s SIGTERM "$d"
    "./luncher.sh" kill -s SIGKILL "$d"
    "./luncher.sh" rm -f "$d"
  fi
    
done


#! TODO: Make sure that OMD known the most recent states (trigger update?)

#! Stop the monitoring agent - last with a delay 
for d in ${background_services}; do
  if [ "x$d" = "xomd_agent" ]; then
  
    echo "Stop/kill/rm BG Service: '$d'..."
    
    if [ -n "${COMPOSE_FILE}" ]; then
      F="${COMPOSE_FILE}.plain"
      rm -f "$F"
      unset COMPOSE_FILE
      "./luncher.sh" config > "$F"
      export COMPOSE_FILE="$F"
    fi

    sleep 10 # ??
    
    "./luncher.sh" stop -t 10 "$d"
    "./luncher.sh" kill -s SIGTERM "$d"
    "./luncher.sh" kill -s SIGKILL "$d"
    "./luncher.sh" rm -f "$d"
  fi    
done
