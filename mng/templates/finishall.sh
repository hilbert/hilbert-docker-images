#!/bin/sh

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
#   echo "export current_app='${current_app}'" > "./lastapp.cfg.new~"

if [ -r "./lastapp.cfg" ]; then
    . "./lastapp.cfg"
    
    d="${current_app}"
    :
else
    d="${default_app}"
    :
fi

if [ -n "$d" ]; then
    echo "Stop/kill/rm FG GUI App: '$d'..."

    "./luncher.sh" stop -t 10 "$d"
    "./luncher.sh" kill -s SIGTERM "$d"
    "./luncher.sh" kill -s SIGKILL "$d"
    "./luncher.sh" rm -f "$d"
fi

## TODO: FIXME: in reversed order!?
for d in ${background_services}; do
    echo "Stop/kill/rm BG Service: '$d'..."

    "./luncher.sh" stop -t 10 "$d"
    "./luncher.sh" kill -s SIGTERM "$d"
    "./luncher.sh" kill -s SIGKILL "$d"
    "./luncher.sh" rm -f "$d"
done
