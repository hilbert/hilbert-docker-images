#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

set -e

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

if [ -r "$CFG_DIR/lastapp.cfg" ]; then
    . "$CFG_DIR/lastapp.cfg"
else
    export current_app="${default_app}"
    echo "export current_app='${current_app}'" > "$CFG_DIR/lastapp.cfg"
fi

if [ -r "$CFG_DIR/docker.cfg" ]; then
    . "$CFG_DIR/docker.cfg"
fi

if [ -r "$CFG_DIR/compose.cfg" ]; then
    . "$CFG_DIR/compose.cfg"
fi

## install Docker Volume 'local-persist' plugin

docker volume create -d local-persist -o mountpoint=$CFG_DIR/KV --name=KV
docker volume create -d local-persist -o mountpoint=$CFG_DIR/CFG --name=CFG
docker volume create -d local-persist -o mountpoint=$CFG_DIR/OMD --name=OMD
#docker volume create -d local-persist -o mountpoint=$CFG_DIR/KV --name=KV


## export 

# TODO: if DISPLAY is not set seatch in /tmp/.X11-unix/... as in our startX.sh
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f XAUTHORITY nmerge -

for d in ${background_services}; do
  "$CFG_DIR/docker-compose.sh" up -d "$d"
done

# echo "--->>>> '$current_app'"

### TODO: run in a loop?
"$CFG_DIR/docker-compose.sh" up -d "$current_app"
