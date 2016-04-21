#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

if [[ -z "$CFG_DIR" ]]; 
then
    export CFG_DIR="$PWD" 
    # HOME/.config/dockapp"
fi

cd $CFG_DIR

### station id
TARGET_HOST_NAME="$1"

if [[ -z "${TARGET_HOST_NAME}" ]];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

shift

CONFG_DIR="$CFG_DIR/STATIONS"
TARGET_CONFG_DIR="$CONFG_DIR/${TARGET_HOST_NAME}"

DM=${DM:-}

SSH=${SSH:-${DM} ssh}
SCP=${SCP:-${DM} scp}

echo "Local initialization: Using templates ($CFG_DIR/templates/) to create '$TARGET_HOST_NAME'..."

if [[ -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Warning: configuration directory '$TARGET_HOST_NAME' already exists... Overwriting..."
fi

station_type="$1"
station_type="${station_type:-init}"

mkdir -p "${TARGET_CONFG_DIR}/"

cd "$CFG_DIR/templates/"

### TODO: update to newer compose version if necessary!...
DOCKER_COMPOSE_LINUX64_URL="https://github.com/docker/compose/releases/download/1.7.0/docker-compose-Linux-x86_64"

if [[ ! -x ./compose ]];
then

 if hash curl 2>/dev/null; then
   curl -L "${DOCKER_COMPOSE_LINUX64_URL}"  > ./compose && chmod +x ./compose
 elif hash wget 2>/dev/null; then
   wget -q -O - "${DOCKER_COMPOSE_LINUX64_URL}" > ./compose && chmod +x ./compose
 fi

fi 

if [[ ! -x ./compose ]];
then 
   echo "Warning: could not get docker-compose via '${DOCKER_COMPOSE_LINUX64_URL}'! 
         Please download it as '$CFG_DIR/templates/compose' and make it executable!"
fi


for f in $(ls -1 | grep -vE '~$') ; 
do
   case "$f" in 
     *.cfg)  
          sed -e "s#[\$]station_id#$TARGET_HOST_NAME#g"  -e "s#[\$]station_type#$station_type#g" "$f" > "${TARGET_CONFG_DIR}/_$f" && \
          mv -f "${TARGET_CONFG_DIR}/_$f" "${TARGET_CONFG_DIR}/$f"
     ;;
     *.yml)
          grep -v -E '   build: \w+/' "$f" > "${TARGET_CONFG_DIR}/_$f"
          mv -f "${TARGET_CONFG_DIR}/_$f" "${TARGET_CONFG_DIR}/$f"
     ;;    
     *.sh)  
#          cp -fp "$f" "${TARGET_CONFG_DIR}/" 
#	   chmod a+x "${TARGET_CONFG_DIR}/$f"
          ln -sf "$PWD/$f" "${TARGET_CONFG_DIR}/"
     ;;
     *)  
#          cp -fp "$f" "${TARGET_CONFG_DIR}/" 
          ln -sf "$PWD/$f" "${TARGET_CONFG_DIR}/"
     ;;
   esac
   
   chmod a+r "${TARGET_CONFG_DIR}/$f" ||  echo "Warning: something went wrong during initialization of '${TARGET_CONFG_DIR}/$f' out of '$CFG_DIR/templates/$f'!"
done 



cd -

## only files
ls -1X "${TARGET_CONFG_DIR}/" | grep -v list | grep -vE '~$' > "${TARGET_CONFG_DIR}/list"
chmod a+r "${TARGET_CONFG_DIR}/list"

## only directories/stations
ls -1X "${CONFG_DIR}/" | grep -v list > "${CONFG_DIR}/_list" && mv "${CONFG_DIR}/_list" "${CONFG_DIR}/list"
chmod a+r "${CONFG_DIR}/list"
