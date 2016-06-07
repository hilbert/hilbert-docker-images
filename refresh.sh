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
ARGS=$@

BASE_DIR="${BASE_DIR:-${SELFDIR}/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Error: missing configuration directory [${TARGET_CONFG_DIR}] for station '$TARGET_HOST_NAME'!"
   exit 1
fi

cd "${TARGET_CONFG_DIR}/"

## Keep previous configuration data: 
[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg
## TODO: lastapp.cfg?
## [[ -r ./startup.cfg ]] && source ./startup.cfg

unset BASE_DIR
unset TARGET_CONFG_DIR

echo "Re-running init.sh for '${TARGET_HOST_NAME}' with '${ARGS}':"
exec "${SELFDIR}/init.sh" "${TARGET_HOST_NAME}" ${ARGS}
