#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

### station id
TARGET_HOST_NAME="$1"

if [[ -z "${TARGET_HOST_NAME}" ]];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

## CONFG_DIR="${SELFDIR}/STATIONS"

BASE_DIR="${BASE_DIR:-${SELFDIR}/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

shift
PROFILE="$1"

shift
DDMM="$1"

echo "Local initialization: Using templates (${SELFDIR}/templates/) to create '${TARGET_CONFG_DIR}'..."

mkdir -p "${BASE_DIR}/"

if [[ -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Warning: configuration directory '$TARGET_HOST_NAME' already exists... Overwriting..."
fi

mkdir -p "${TARGET_CONFG_DIR}/"

cd "${SELFDIR}/templates/"

export station_id="${TARGET_HOST_NAME}"
[[ -r ./station.cfg ]] && source ./station.cfg
# [[ -r ./access.cfg ]]  && source ./access.cfg
[[ -r ./station.cfg ]] && source ./station.cfg
# [[ -r ./access.cfg ]]  && source ./access.cfg

export station_id="${station_id:-${TARGET_HOST_NAME}}"

PROFILE="${PROFILE:-${station_type}}"
export station_type="${PROFILE}"
unset PROFILE

DDMM="${DDMM:-${DM}}"
export DM="${DDMM}"
unset DDMM



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
         Please download it as '${SELFDIR}/templates/compose' and make it executable!"
fi

for f in $(ls -1 | grep -vE '~$') ; 
do
   case "$f" in 
     *.cfg)  
          sed \
	     -e "s#[\$]WOL#$WOL#g" \
	     -e "s#[\$]DM#$DM#g"  \
	     -e "s#[\$]SCP#$SCP#g" \
	     -e "s#[\$]SSH#$SSH#g" \
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
   
   chmod a+r "${TARGET_CONFG_DIR}/$f" ||  echo "Warning: something went wrong during initialization of '${TARGET_CONFG_DIR}/$f' out of '${SELFDIR}/templates/$f'!"
done 

## only files
cd "${TARGET_CONFG_DIR}/"

touch md5 list

ls -1 | grep -vE '^(.*~)$' > "list~"
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 | grep -vE '^(md5|.*~)$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

cd "${BASE_DIR}/"
## TODO: only directories/stations
ls -1 | grep -vE '^(list|md5|.*~)$' > "list~" 
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 */md5 | grep -vE '^[^/]*~/md5$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

exit 0
