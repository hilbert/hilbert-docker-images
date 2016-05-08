#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

if [[ -z "$CFG_DIR" ]]; 
then
    export CFG_DIR="$PWD" 
    # '~/.config/dockapp'
fi

cd $CFG_DIR

### station id
export station_id="$1"

if [[ -z "${station_id}" ]];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

## CONFG_DIR="${CFG_DIR}/STATIONS"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${station_id}"

shift
export station_type="$1"

echo "Local initialization: Using templates (${CFG_DIR}/templates/) to create '${TARGET_CONFG_DIR}'..."

mkdir -p "${BASE_DIR}/"

if [[ -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Warning: configuration directory '$station_id' already exists... Overwriting..."
fi

mkdir -p "${TARGET_CONFG_DIR}/"

cd "$CFG_DIR/templates/"

source ./station.cfg

### TODO: update to newer compose version if necessary!...
# `uname -s`-`uname -m`
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
          sed \
	     -e "s#[\$]DM#$DM#g" \
	     -e "s#[\$]station_id#$station_id#g" \
	     -e "s#[\$]station_type#$station_type#g" \
	     -e "s#[\$]IP_ADDRESS#$IP_ADDRESS#g" \
	     -e "s#[\$]MAC_ADDRESS#$MAC_ADDRESS#g" \
	       "$f" > "${TARGET_CONFG_DIR}/$f~" && \
          mv -f "${TARGET_CONFG_DIR}/$f~" "${TARGET_CONFG_DIR}/$f"
     ;;
     *.yml)
          grep -v -E '   build: \w+/' "$f" > "${TARGET_CONFG_DIR}/$f~"
          mv -f "${TARGET_CONFG_DIR}/$f~" "${TARGET_CONFG_DIR}/$f"
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
cd "${TARGET_CONFG_DIR}/"

touch md5 list

ls -1 | grep -vE '^(.*~)$' > "list~"
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 | grep -vE '^(md5|.*~)$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

cd -


cd "${BASE_DIR}/"
## TODO: only directories/stations
ls -1 | grep -vE '^(list|md5|.*~)$' > "list~" 
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 */md5 | grep -vE '^[^/]*~/md5$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

cd -

