#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`
cd "${SELFDIR}/"

### CONFIG_PORT="${CONFIG_PORT:-8080}"
### CONFIG_HOST="${CONFIG_HOST:-`hostname -f`}"
### URL="http://${CONFIG_HOST}:${CONFIG_PORT}"

## CONFIG_BASE_URL=${CONFIG_BASE_URL:-"${URL}"}

### station id:
TARGET_HOST_NAME="$1"
shift

if [[ -z "${TARGET_HOST_NAME}" ]];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

## CONFG_DIR="${SELFDIR}/STATIONS"

# NOTE: 1st synchronize with upstream CMS???
./sync.sh "${TARGET_HOST_NAME}" || exit $?

BASE_DIR="${BASE_DIR:-${SELFDIR}/STATIONS}"
TARGET_CONFG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

if [[ ! -d "${TARGET_CONFG_DIR}/" ]];
then 
   echo "Error: missing configuration directory [${TARGET_CONFG_DIR}] for station '$TARGET_HOST_NAME'!"
   exit 1
fi

cd "${TARGET_CONFG_DIR}/"

[[ -r ./station.cfg ]] && source ./station.cfg
[[ -r ./access.cfg ]]  && source ./access.cfg

LIST=$(cat "./list" | xargs)

cd "${SELFDIR}/"

#TARGET_CFG_DIR="$CFG_DIR/STATIONS/${TARGET_HOST_NAME}"
#CONFIG_URL="${CONFIG_BASE_URL}/${TARGET_HOST_NAME}"

#### TODO: sync local cache with remote CONFIG HTTP server
#### TODO: switch to using SCP from current server cache!
#### TODO: sync lastapp.cfg with the remote station

echo "Pushing configs for station '${TARGET_HOST_NAME}' (into '${CFG_DIR}'), using '${SCP}' and '${SSH}'..."

# ./remote.sh "${TARGET_HOST_NAME}" "

echo "List of configuration files: [$LIST]"

./remote.sh "${TARGET_HOST_NAME}"  "mkdir -p ~/.config/dockapp/bak"

./remote.sh "${TARGET_HOST_NAME}"  "test -d ~/.config/dockapp" >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "ERROR: Cannot access '~/.config/dockapp' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

SUDO=""

   ./remote.sh "${TARGET_HOST_NAME}"  "test -w ~/.config/dockapp" >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "Warning: directory '~/.config/dockapp' is not writable: "
      ./remote.sh "${TARGET_HOST_NAME}"  "ls -la ~/.config/dockapp"
      SUDO="sudo"
   fi



# ./remote.sh "${TARGET_HOST_NAME}" "mktemp -d"
TMP="/tmp/temp.deploy.`date`"
./remote.sh "${TARGET_HOST_NAME}" "mkdir -p '${TMP}/'"
# echo "Temp directory: [$TMP]"
#### ./remote.sh "${TARGET_HOST_NAME}"  "chmod 0777 $TMP"
# ./remote.sh "${TARGET_HOST_NAME}"  "ls -laR /tmp/"

# TODO: use rsync, e.g. rsync -urltv --delete -e ssh /src.dir othermachine:/src.dir

for f in $LIST ; do 
   g="${TARGET_CONFG_DIR}/$f"

   ${SCP} "$g" "${station_id}:'$TMP/$f'"
   if [ $? -ne 0 ]; then
      echo "ERROR: could not copy the configuration file '$g' (with '${SCP}') into '$TMP/$f' at '${station_id}' (for '${TARGET_HOST_NAME}')!"
      exit 1
   fi

   # Make sure all new files are present
   ./remote.sh "${TARGET_HOST_NAME}"  "test -f '$TMP/$f'"  >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "ERROR: Could not download '$f' into [$TMP] on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi
  
   if [[ -x "$g" ]]; then
        ./remote.sh "${TARGET_HOST_NAME}" "chmod a+x '$TMP/$f'"
        if [ $? -ne 0 ]; then
           echo "ERROR: Could not add executable permission bit for '$TMP/$f' on station '${TARGET_HOST_NAME}'!"
           exit 1
        fi
    fi

   ./remote.sh "${TARGET_HOST_NAME}"  "test -f ~/.config/dockapp/$f"  >/dev/null 2>&1
   if [ ! $? -ne 0 ]; then
      ./remote.sh "${TARGET_HOST_NAME}"  "test -w ~/.config/dockapp/$f"  >/dev/null 2>&1
      if [ $? -ne 0 ]; then
         echo "Warning: existing file '~/.config/dockapp/$f' is not writable: "
         ./remote.sh "${TARGET_HOST_NAME}"  "ls -la ~/.config/dockapp/$f"
         SUDO="sudo"
      fi
   fi      

done


# 1 level (previous state) backup (if necessary/possible)
./remote.sh "${TARGET_HOST_NAME}"  "cd ~/.config/dockapp/ && cp -f $LIST ~/.config/dockapp/bak/ || echo 'Failed backup...'"

if [ ! -z "$SUDO" ]; then
  echo "Warning: sudo cp may be required for copying [$LIST] from '$TMP' into '~/.config/dockapp/'..."
fi

#### TODO: proper atomic update?!
./remote.sh "${TARGET_HOST_NAME}"  "cd '${TMP}' && cp -f $LIST ~/.config/dockapp/ && ls -ltX ~/.config/dockapp/"

   if [ $? -ne 0 ]; then
      echo "ERROR: Could not copy new configs [$LIST] from '$TMP' to '~/.config/dockapp/' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

# Cleanup only if no errors were detected... 
./remote.sh "${TARGET_HOST_NAME}"  "rm -Rf '${TMP}'" 

# && ls -la ~/.config/dockapp && export A=\$(mktemp -d -p ~/.config) && chmod 0777 \"\$TMP\" && cp -r ~/.config/dockapp/* \"\$TMP/\" && \
#for f in \$L ; do wget -O \"\$TMP/\$f\" \"${CONFIG_URL}/\$f\" || exit 1; done && \
#mv -f ~/.config/dockapp ~/.config/dockapp.bak && mv -f \"\$TMP\" ~/.config/dockapp && ls -la ~/.config/dockapp"

exit 0
