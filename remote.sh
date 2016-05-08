#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

cd $SELFDIR

# set -e

TARGET_HOST_NAME="$1"

   if [ -z "${TARGET_HOST_NAME}" ]; then
      echo "ERROR: no station (1st) argument given to this script $0: [$@]!"
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
source ./station.cfg
cd -

echo "Running command: '${CMD_ARGS}' on station '${TARGET_HOST_NAME}' via '${SSH}'..."
${SSH} ${CMD_ARGS}
