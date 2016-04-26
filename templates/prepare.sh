#! /bin/sh

### Preparation for actual docker-framework

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

### set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

#### TODO: needs some safety check to avoid multiple runs...

## install Docker Volume 'local-persist' plugin following https://github.com/CWSpear/local-persist
##curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash

cd $CFG_DIR

### TODO: update to newer compose version if necessary!...
DOCKER_COMPOSE_LINUX64_URL="https://github.com/docker/compose/releases/download/1.7.0/docker-compose-Linux-x86_64"

if [[ ! -f ./compose ]];
then

 if hash curl 2>/dev/null; then
   curl -L "${DOCKER_COMPOSE_LINUX64_URL}"  > ./compose && chmod +x ./compose
 elif hash wget 2>/dev/null; then
   wget -q -O - "${DOCKER_COMPOSE_LINUX64_URL}" > ./compose && chmod +x ./compose
 fi

fi 

if [[ ! -f ./compose ]];
then 
   echo "Warning: could not get docker-compose via '${DOCKER_COMPOSE_LINUX64_URL}'! 
         Please download it as '$CFG_DIR/compose' and make it executable!"
fi

chmod a+x ./compose

## cd ./tmp/
### TODO: add the plugin for global installation?
#curl -fsSL https://github.com/CWSpear/local-persist/releases/download/v1.1.0/local-persist-linux-amd64 > ./local-persist-linux-amd64
#chmod +x ./local-persist-linux-amd64
#sudo ./local-persist-linux-amd64 1>./local-persist-linux-amd64.log 2>&1 &

### add me to all the necessary groups etc ...
#if [ ! -L "$CFG_DIR/CFG" ]; then
#   ln -sf "$CFG_DIR" "$CFG_DIR/CFG"
#fi

#docker volume create -d local-persist -o mountpoint="$CFG_DIR/KV" --name=KV
#docker volume create -d local-persist -o mountpoint="$CFG_DIR/OMD" --name=OMD
#docker volume create -d local-persist -o mountpoint="$CFG_DIR/CFG" --name=CFG

./ptmx.sh >/dev/null 2>&1 &


if [[ -f ./OGL.tgz ]];
then
  cp -fp ./OGL.tgz /tmp/ || sudo -n -P cp -fp ./OGL.tgz /tmp/
fi

cd -
