#!/bin/bash

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

export station_id="${TARGET_HOST_NAME}"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${station_id}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Error: missing configuration directory [${TARGET_CONFG_DIR}] for station '$station_id'!"
   exit 1
fi

cd "${TARGET_CONFG_DIR}/"

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg

cd "${SELFDIR}/"


if [ -z "${WOL}" ]; then 

  if [ "${DM}" = "docker-machine" ]; then
  
    DM_HOST="${DM_HOST:-supernova}"
    if [ -n "${DM_HOST}" ]; then
      DM="${SELFDIR}/remote.sh ${DM_HOST} ${DM}"
    fi

    export WOL="${DM} start ${station_id}"
  else  

    if [ ! -z "${MAC_ADDRESS}" ]; then  
      [ -z "${IP_ADDRESS}" ] \
        && export WOL="wakeonlan ${MAC_ADDRESS}" \
        || export WOL="wakeonlan -i ${IP_ADDRESS} ${MAC_ADDRESS}"
    fi
    
  fi
fi
  
if [ -z "${WOL}" ]; then 
  echo "ERROR: missing boot-up or wake-up procedure for this station: '${station_id}'!"
  exit 1
fi

echo "Starting station '${TARGET_HOST_NAME}' via '${WOL} ${CMD_ARGS}': "
exec ${WOL} ${CMD_ARGS}
