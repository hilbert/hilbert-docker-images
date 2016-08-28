#! /bin/sh

### Preparation for actual docker-framework

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## unset DISPLAY

### set -e
cd "${SELFDIR}/"

#### TODO: needs some safety check to avoid multiple runs...

## install Docker Volume 'local-persist' plugin following https://github.com/CWSpear/local-persist
##curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash

### TODO: update to newer compose version if necessary!...
DOCKER_COMPOSE_LINUX64_URL="https://github.com/docker/compose/releases/download/1.8.0/docker-compose-Linux-x86_64"

if [ ! -f ./compose ];
then

 if hash curl 2>/dev/null; then
   curl -L "${DOCKER_COMPOSE_LINUX64_URL}"  > ./compose && chmod +x ./compose
 elif hash wget 2>/dev/null; then
   wget -q -O - "${DOCKER_COMPOSE_LINUX64_URL}" > ./compose && chmod +x ./compose
 fi

fi 

if [ ! -f ./compose ];
then 
   echo "Warning: could not get docker-compose via '${DOCKER_COMPOSE_LINUX64_URL}'! 
         Please download it as '$PWD/compose' and make it executable!"
fi

chmod a+x ./compose

#! Finish our services (possible left-overs due to some crash)
./finishall.sh

#! Clean-up the rest of containers
## TODO: FIXME: corner case: nothing to kill - do nothing! 
docker ps -aq | xargs docker rm -fv

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


#! TODO: FIXME: SUDO!
### ./ptmx.sh >/dev/null 2>&1 &

if [ -f ./OGL.tgz ];
then
  cp -fp ./OGL.tgz /tmp/ || sudo -n -P cp -fp ./OGL.tgz /tmp/
fi

if hash ethtool 2>/dev/null; then
  sudo ethtool -s "${NET_IF}" wol g
fi

# if [ -e "/tmp/lastapp.cfg" ]; then
#     
# if [ -w "/tmp/lastapp.cfg" ]; then
#     rm -f "/tmp/lastapp.cfg"
# else
#     sudo rm -f "/tmp/lastapp.cfg"
# fi
# 
# fi

### docker login -u malex984 -p ... ... imaginary.mfo.de:5000

D="${HOME}/.docker/"
F="${D}/config.json"

mkdir -p "${D}"
cat > "${F}~" <<EOF
{
	"auths": {
		"imaginary.mfo.de:5000": {
			"auth": "bWFsZXg5ODQ6MzJxMzJx"
		}
	}
}
EOF
mv "${F}~" "${F}"


if [ -r "./station.cfg" ]; then
    . "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    . "./startup.cfg"
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

station_default_app="${station_default_app:-$default_app}"

if [ -r "/tmp/lastapp.cfg" ]; then
    . "/tmp/lastapp.cfg"
else
    export current_app="${station_default_app}"
fi

for d in ${background_services}; do
  echo "Pulling Image for background Service: '${d}'..."
  "./luncher.sh" pull --ignore-pull-failures "${d}"
done


if [ -n "${current_app}" ]; then
  echo "Pulling image for Front GUI Application: '${current_app}'..."
  "./luncher.sh" pull --ignore-pull-failures "${current_app}"
fi




exit 0

