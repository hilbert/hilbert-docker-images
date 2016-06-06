#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

# set -e

TARGET_HOST_NAME="$1"

   if [ -z "${TARGET_HOST_NAME}" ]; then
      echo "ERROR: no station argument was specified to this script [$0]! (other arguments were: '$@')" 1>&2
      exit 1
   fi

shift
CMD_ARGS=$@

export station_id="${TARGET_HOST_NAME}"

export BASE_DIR="${BASE_DIR:-$PWD/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${station_id}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Error: missing configuration directory [${TARGET_CONFG_DIR}] for station '$station_id'!" 1>&2
   exit 1
fi

cd "${TARGET_CONFG_DIR}/"

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg

cd "$SELFDIR/"

echo "Running command: '${CMD_ARGS}' on station '${TARGET_HOST_NAME}' via '${SSH}'..." 1>&2
exec ${SSH} "${station_id}" ${CMD_ARGS}
