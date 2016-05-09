#! /bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e
unset DISPLAY


if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

cd $CFG_DIR

if [ -r "$CFG_DIR/station.cfg" ]; then
    . "$CFG_DIR/station.cfg"
fi

if [ -r "$CFG_DIR/startup.cfg" ]; then
    . "$CFG_DIR/startup.cfg"
fi

#if [ -r "$CFG_DIR/docker.cfg" ]; then
#    . "$CFG_DIR/docker.cfg"
#fi

#if [ -r "$CFG_DIR/compose.cfg" ]; then
#    . "$CFG_DIR/compose.cfg"
#fi

#   export current_app="${default_app}"
#   echo "export current_app='${current_app}'" > "$CFG_DIR/lastapp.cfg"


for d in ${background_services}; do
  "$CFG_DIR/luncher.sh" stop "$d"
  "$CFG_DIR/luncher.sh" kill "$d"
  "$CFG_DIR/luncher.sh" rm -f "$d"
done

# echo "--->>>> '$current_app'"

### TODO: run in a loop?

if [ -r "$CFG_DIR/lastapp.cfg" ]; then
    . "$CFG_DIR/lastapp.cfg"
    
    d="${current_app}"
 
    "$CFG_DIR/luncher.sh" stop "$d"
    "$CFG_DIR/luncher.sh" kill "$d"
    "$CFG_DIR/luncher.sh" rm -f "$d"
    
else

    d="${default_app}"
 
    "$CFG_DIR/luncher.sh" stop "$d"
    "$CFG_DIR/luncher.sh" kill "$d"
    "$CFG_DIR/luncher.sh" rm -f "$d"
    
fi
