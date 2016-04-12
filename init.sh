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


TARGET_CFG_DIR="$CFG_DIR/STATIONS/${TARGET_HOST_NAME}"

DM=${DM:-}

SSH=${SSH:-${DM} ssh}
SCP=${SCP:-${DM} scp}

echo "Local initialization: Using templates ($CFG_DIR/templates/) to create '$TARGET_HOST_NAME'..."

if [[ -d "${TARGET_CFG_DIR}/" ]];
then 
   echo "Warning: configuration directory '$TARGET_HOST_NAME' already exists... Overwriting..."
fi

shift
station_type="$1"
station_type="${station_type:-init}"

mkdir -p "${TARGET_CFG_DIR}/"

cd "$CFG_DIR/templates/"

cp -f *.sh "${TARGET_CFG_DIR}/"

for d in *.cfg ; 
do
  sed -e "s#[\$]station_id#$TARGET_HOST_NAME#g"  -e "s#[\$]station_type#$station_type#g" "$d" > "${TARGET_CFG_DIR}/_$d"
  mv -f "${TARGET_CFG_DIR}/_$d" "${TARGET_CFG_DIR}/$d"
done

for d in *.yml ; 
do
  grep -v -E '   build: \w+/' "$d" > "${TARGET_CFG_DIR}/_$d"
  mv -f "${TARGET_CFG_DIR}/_$d" "${TARGET_CFG_DIR}/$d"
done

cd -
