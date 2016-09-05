#!/bin/bash -xv

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# set -e

TARGET_HOST_NAME="$1"

if [[ -z "${TARGET_HOST_NAME}" ]];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

cd "$SELFDIR/"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "ERROR: missing configuration directory [${TARGET_CONFG_DIR}] for station '$TARGET_HOST_NAME'!"
   exit 1
fi

MSG=`./status.sh "${TARGET_HOST_NAME}"`
if [[ $? -ne 0 ]]; then
  echo "ERROR: could not access '${TARGET_HOST_NAME}'"
  exit 1
fi

cd "${TARGET_CONFG_DIR}/" 

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg  ]] && source ./access.cfg

# [[ -r ./startup.cfg ]] && source ./startup.cfg
# station_default_app="${station_default_app:-$default_app}"

f="lastapp.cfg"

mkdir -p "./~/"
${SCP} "${station_id}:/tmp/$f" "./~/$f"
if [[ $? -ne 0 ]]; then
  echo "ERROR: could not get '${station_id}:/tmp/$f'!"
  exit 1
fi

chmod go+rw "./~/$f"

mv --backup=numbered -f -- "./~/$f" .
if [[ $? -ne 0 ]]; then
  echo "ERROR: could not mv './~/$f' into $PWD!"
  exit 1
fi

source "./$f"
if [[ $? -ne 0 ]]; then
  echo "ERROR: could not source '$PWD/$f'"
  exit 1
fi

cd "$SELFDIR/"

#current_app="${current_app:-$station_default_app}"
#echo "${current_app}"
 
exit 0



${SSH} "${station_id}" \
'cd /tmp && [ -r ./lastapp.cfg ] && . ./lastapp.cfg && [ -n "${current_app}" ] && echo "${current_app}"'
if [[ $? -ne 0 ]]; then
##  echo "ERROR: no configuration directory (${CFG_DIR}). Please deploy first!" 1>&2
  echo "${station_default_app}"
  exit 1
fi

exit 0

#${SSH} "${station_id}" "[ -r \"${CFG_DIR}/lastapp.cfg\" ] || exit 1"
#if [[ $? -ne 0 ]]; then
##  echo "ERROR: no last app configuration file: (${CFG_DIR}/lastapp.cfg). Please start beforehand!" 1>&2
#  echo "${station_default_app}"
#  exit 0
#fi



