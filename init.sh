#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

set -e

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

cp -f *.sh "${TARGET_CONFG_DIR}/"

for d in *.cfg ; 
do
  sed -e "s#[\$]station_id#$TARGET_HOST_NAME#g"  -e "s#[\$]station_type#$station_type#g" "$d" > "${TARGET_CONFG_DIR}/_$d"
  mv -f "${TARGET_CONFG_DIR}/_$d" "${TARGET_CONFG_DIR}/$d"
done

for d in *.yml ; 
do
  grep -v -E '   build: \w+/' "$d" > "${TARGET_CONFG_DIR}/_$d"
  mv -f "${TARGET_CONFG_DIR}/_$d" "${TARGET_CONFG_DIR}/$d"
done

cd -

ls -1X "${TARGET_CONFG_DIR}/" | grep -v list > "${TARGET_CONFG_DIR}/list"
chmod a+r "${TARGET_CONFG_DIR}/list"

ls -1X "${CONFG_DIR}/" | grep -v list > "${CONFG_DIR}/_list" && mv "${CONFG_DIR}/_list" "${CONFG_DIR}/list"
chmod a+r "${CONFG_DIR}/list"
