#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# set -e

TARGET_HOST_NAME="$1"

   if [ -z "${TARGET_HOST_NAME}" ]; then
      echo "ERROR: no station argument was specified to this script [$0]! (other arguments were: '$@')"
      exit 1
   fi

shift
CMD_ARGS=$@

# export station_id="${TARGET_HOST_NAME}"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Error: missing configuration directory [${TARGET_CONFG_DIR}] for station '${TARGET_HOST_NAME}'!"
   exit 1
fi

cd "${TARGET_CONFG_DIR}/"

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg

cd "${SELFDIR}/"


if [[ "${DM}" = "docker-machine" ]]; then
  st=`${DM} status "${station_id}"`
  [[ "${st}" = "Stopped" ]] && exit 1
fi

# echo "Checking the status for station '${TARGET_HOST_NAME}' via '${SSH}': "

./remote.sh "${TARGET_HOST_NAME}" "exit 0" &> /dev/null
[[ $? -ne 0 ]] && exit 1

exit 0 # Up and running!
