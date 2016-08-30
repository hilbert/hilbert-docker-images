#!/bin/bash

set -v
set -x

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# set -e

TARGET_HOST_NAME="$1"

if [ -z "${TARGET_HOST_NAME}" ]; then
  echo "ERROR: no station argument was specified to this script [$0]! (other arguments were: '$@')"
  exit 2
fi

shift
CMD_ARGS=$@

# export station_id="${TARGET_HOST_NAME}"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
  echo "ERROR: missing configuration directory [${TARGET_CONFG_DIR}] for station '${TARGET_HOST_NAME}'!"
  exit 2
fi

cd "${TARGET_CONFG_DIR}/"

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg

cd "${SELFDIR}/"


# echo "Checking the status for station '${TARGET_HOST_NAME}' (DM: '${DM}', ID: '${station_id}'): "

if [ "x${DM}" = "xdocker-machine" ]; then
 if hash "${DM}" 2>/dev/null; then 

  st=`LANG=C ${DM} status "${station_id}"`
  if [[ $? -ne 0 ]]; then
    echo "ERROR: unknown Virtual Station: '${station_id}' (${TARGET_HOST_NAME})!"
    exit 2
  fi
  
  if [ ! "x${st}" = "xRunning" ]; then
    echo "NOTE: Virtual Station '${station_id}' (${TARGET_HOST_NAME}) is not running!"
    exit 1
  fi

  # note ip may change for virtual stations
  unset IP_ADDRESS 

  [[ -z "${IP_ADDRESS}" ]] && export IP_ADDRESS=`LANG=C ${DM} ip "${station_id}"`
# else
#   echo "ERROR: missing '${DM}'!"
#   exit 2
 fi
fi

if [[ -z "${IP_ADDRESS}" ]]; then
  echo "ERROR: unknown IP ADDRESS for '${station_id}' (${TARGET_HOST_NAME})!"
  exit 2
fi

LANG=C ping -c2 -t2 "${IP_ADDRESS}" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "NOTE: cannot ping '${station_id}' (${TARGET_HOST_NAME}) via network!"
  exit 1
fi

./remote.sh "${TARGET_HOST_NAME}" "exit 0" &> /dev/null
if [[ $? -ne 0 ]]; then
  echo "NOTE: cannot access '${station_id}' (${TARGET_HOST_NAME}) via ssh!"
  exit 1
fi

echo "NOTE: ${TARGET_HOST_NAME} is UP, RUNNING and ACCESSIBLE!"
exit 0
# Up, running and accessible!

