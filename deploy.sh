#!/bin/sh

#SELFDIR=`dirname "$0"`
#SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

#if [ -z "$CFG_DIR" ]; then
#    export CFG_DIR="$PWD" 
#    # HOME/.config/dockapp"
#fi

# cd $CFG_DIR

CONFIG_PORT="${CONFIG_PORT:-8080}"
CONFIG_HOST="${CONFIG_HOST:-`hostname --long`}"
URL="http://${CONFIG_HOST}:${CONFIG_PORT}"

CONFIG_BASE_URL=${CONFIG_BASE_URL:-"${URL}"}

### station id:
TARGET_HOST_NAME="$1"
shift

#TARGET_CFG_DIR="$CFG_DIR/STATIONS/${TARGET_HOST_NAME}"
CONFIG_URL="${CONFIG_BASE_URL}/${TARGET_HOST_NAME}"

DM=${DM:-}
SSH=${SSH:-${DM} ssh}
# SCP=${SCP:-${DM} scp}

echo "Pulling '${CONFIG_URL}' on station '${TARGET_HOST_NAME}' into '~/.config/dockapp/', via: ${SSH}..."

$SSH "${TARGET_HOST_NAME}" "wget -q --spider '${CONFIG_URL}/list'"
if [ $? -ne 0 ]; then
   echo "ERROR: no configuration accessible at '${CONFIG_URL}' from station '${TARGET_HOST_NAME}'!"
   exit 1
fi

LIST=`$SSH "${TARGET_HOST_NAME}" "wget -q -O - '${CONFIG_URL}/list'" | xargs`

echo "List of configuration files: [$LIST]"

for f in $LIST ; do 
   $SSH "${TARGET_HOST_NAME}" "wget -q --spider '${CONFIG_URL}/$f'"
   if [ $? -ne 0 ]; then
      echo "ERROR: configuration file '$f' is inaccessible via '${CONFIG_URL}/$f' from station '${TARGET_HOST_NAME}'!"
      exit 1
   fi
done

#### $SSH "${TARGET_HOST_NAME}"  "rm -Rf ~/.config"

$SSH "${TARGET_HOST_NAME}"  "mkdir -p ~/.config/dockapp/bak"

$SSH "${TARGET_HOST_NAME}"  "test -d ~/.config/dockapp" >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "ERROR: Cannot access '~/.config/dockapp' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

SUDO=""

   $SSH "${TARGET_HOST_NAME}"  "test -w ~/.config/dockapp" >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "Warning: directory '~/.config/dockapp' is not writable: "
      $SSH "${TARGET_HOST_NAME}"  "ls -la ~/.config/dockapp"
      SUDO="sudo"
   fi



TMP=`$SSH "${TARGET_HOST_NAME}" "mktemp -d"`

# echo "Temp directory: [$TMP]"
#### $SSH "${TARGET_HOST_NAME}"  "chmod 0777 $TMP"
# $SSH "${TARGET_HOST_NAME}"  "ls -laR /tmp/"


for f in $LIST ; do 
   $SSH "${TARGET_HOST_NAME}" "wget -q -O '$TMP/$f' '${CONFIG_URL}/$f'"
   if [ $? -ne 0 ]; then
      echo "ERROR: configuration file '$f' is inaccessible via '${CONFIG_URL}/$f' from station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

   # Make sure all new files are present
   $SSH "${TARGET_HOST_NAME}"  "test -f '$TMP/$f'"  >/dev/null 2>&1
   if [ $? -ne 0 ]; then
      echo "ERROR: Could not download '$f' into [$TMP] on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi
  
   case "$f" in
     compose|*.sh)
        $SSH "${TARGET_HOST_NAME}" "chmod a+x '$TMP/$f'"
        if [ $? -ne 0 ]; then
           echo "ERROR: Could not add executable permission bit for '$TMP/$f' on station '${TARGET_HOST_NAME}'!"
           exit 1
        fi
     ;;
   esac

   $SSH "${TARGET_HOST_NAME}"  "test -f ~/.config/dockapp/$f"  >/dev/null 2>&1
   if [ ! $? -ne 0 ]; then
      $SSH "${TARGET_HOST_NAME}"  "test -w ~/.config/dockapp/$f"  >/dev/null 2>&1
      if [ $? -ne 0 ]; then
         echo "Warning: existing file '~/.config/dockapp/$f' is not writable: "
         $SSH "${TARGET_HOST_NAME}"  "ls -la ~/.config/dockapp/$f"
         SUDO="sudo"
      fi
   fi      

done


# 1 level (previous state) backup (if necessary/possible)
$SSH "${TARGET_HOST_NAME}"  "cd ~/.config/dockapp/ && cp -f $LIST ~/.config/dockapp/bak/ 1>/dev/null 2>&1 || echo 'Failed backup...'"

if [ ! -z "$SUDO" ]; then
  echo "Warning: sudo cp may be required for copying [$LIST] from '$TMP' into '~/.config/dockapp/'..."
fi

#### TODO: proper atomic update?!
$SSH "${TARGET_HOST_NAME}"  "cd $TMP && cp -f $LIST ~/.config/dockapp/ && ls -ltX ~/.config/dockapp/"

   if [ $? -ne 0 ]; then
      echo "ERROR: Could not copy new configs [$LIST] from '$TMP' to '~/.config/dockapp/' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

# Cleanup only if no errors were detected... 
$SSH "${TARGET_HOST_NAME}"  "rm -Rf $TMP" 

# && ls -la ~/.config/dockapp && export A=\$(mktemp -d -p ~/.config) && chmod 0777 \"\$TMP\" && cp -r ~/.config/dockapp/* \"\$TMP/\" && \
#for f in \$L ; do wget -O \"\$TMP/\$f\" \"${CONFIG_URL}/\$f\" || exit 1; done && \
#mv -f ~/.config/dockapp ~/.config/dockapp.bak && mv -f \"\$TMP\" ~/.config/dockapp && ls -la ~/.config/dockapp"

exit 0
