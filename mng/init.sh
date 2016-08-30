#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

### station id
TARGET_HOST_NAME="$1"

if [ -z "${TARGET_HOST_NAME}" ];
then 
   echo "ERROR: station name is missing!"
   exit 1
fi

## CONFG_DIR="${SELFDIR}/STATIONS"

BASE_DIR="${BASE_DIR:-${SELFDIR}/STATIONS}"
TARGET_CONFIG_DIR="${BASE_DIR}/${TARGET_HOST_NAME}"

shift
PROFILE="$1"

shift
DDMM="$1"

echo "Local initialization: Using templates (${SELFDIR}/templates/) to create '${TARGET_CONFIG_DIR}'..."

mkdir -p "${BASE_DIR}/"

if [ -d "${TARGET_CONFIG_DIR}/" ];
then 
   echo "Warning: configuration directory '$TARGET_HOST_NAME' already exists... Overwriting..."
fi

mkdir -p "${TARGET_CONFIG_DIR}/~/"

cd "${SELFDIR}/templates/"

#! NOTE: there maybe some env. vars. already set from outside!

export station_id="${TARGET_HOST_NAME}"

[ -r ./startup.cfg ] && source ./startup.cfg
[ -r ./station.cfg ] && source ./station.cfg
[ -r ./access.cfg  ] && source ./access.cfg

## TODO: FIXME: document where do we need the following?
PROFILE="${PROFILE:-${station_type}}"
export station_type="${PROFILE}"
unset PROFILE

#! Some defaults:
export station_id="${station_id:-${TARGET_HOST_NAME}}"

if [ -z "${CFG_DIR}" ]; then
  export CFG_DIR=".config/dockapp"
fi


DDMM="${DDMM:-${DM}}"
export DM="${DDMM}"
unset DDMM

if [ -z "${station_default_app}" ] && [ -n "${default_app}" ]; then
  export station_default_app="${default_app}"
fi

if [ -z "${station_descr}" ]; then
  export station_descr="Station '${station_id}': ${station_type} / ${station_default_app}"
fi

# [ -r ./station.cfg ] && source ./station.cfg
[ -r ./startup.cfg ] && source ./startup.cfg
[ -r ./access.cfg  ] && source ./access.cfg


### TODO: update to newer compose version if necessary!...
# `uname -s`-`uname -m`
DOCKER_COMPOSE_LINUX64_URL="https://github.com/docker/compose/releases/download/1.8.0/docker-compose-Linux-x86_64"

if [ ! -x ./compose ];
then

 if hash curl 2>/dev/null; then
   curl -L "${DOCKER_COMPOSE_LINUX64_URL}"  > ./compose && chmod +x ./compose
 elif hash wget 2>/dev/null; then
   wget -q -O - "${DOCKER_COMPOSE_LINUX64_URL}" > ./compose && chmod +x ./compose
 fi

fi 

if [ ! -x ./compose ];
then
   echo \
"Warning: could not get docker-compose via '${DOCKER_COMPOSE_LINUX64_URL}'! 
Please download it as '${SELFDIR}/templates/compose' and make it executable!"

fi

for f in $(cat list | grep -vE '~$') ; 
do
   case "$f" in 
     station.cfg)  
          sed \
	     -e "s#[\$]station_id#${station_id}#g" \
	     -e "s#[\$]station_type#${station_type}#g" \
	     -e "s#[\$]station_default_app#${station_default_app}#g" \
	     -e "s#[\$]station_descr#${station_descr}#g" \
	     -e "s#[\$]CFG_DIR#${CFG_DIR}#g" \
	     -e "s#[\$]IP_ADDRESS#${IP_ADDRESS}#g" \
	     -e "s#[\$]MAC_ADDRESS#${MAC_ADDRESS}#g" \
	     -e "s#[\$]SSH_OPTS#${SSH_OPTS}#g" \
	     -e "s#[\$]SSH_USER#${SSH_USER}#g" \
	     -e "s#[\$]SSH_PORT#${SSH_PORT}#g" \
	     -e "s#[\$]SSH_KEY#${SSH_KEY}#g" \
	     -e "s#[\$]SCP#${SCP}#g" \
	     -e "s#[\$]SSH#${SSH}#g" \
	     -e "s#[\$]WOL#${WOL}#g" \
	     -e "s#[\$]DM#${DM}#g"  \
	       "$f" > "${TARGET_CONFIG_DIR}/~/$f"
     ;;
     *.yml)
          grep -v -E '^ *build: .*\w+/? *$' "$f" > "${TARGET_CONFIG_DIR}/~/$f"
     ;;    
#     *.sh)  
#          cp -fp "$f" "${TARGET_CONFIG_DIR}/" 
#	   chmod a+x "${TARGET_CONFIG_DIR}/$f"
#          ln -sf "$PWD/$f" "${TARGET_CONFIG_DIR}/"
#     ;;
     Dockerfile)
          cp -fp "$f" "${TARGET_CONFIG_DIR}/" 
     ;;
     *)  
#          cp -fp "$f" "${TARGET_CONFIG_DIR}/" 
          ln -sf "$PWD/$f" "${TARGET_CONFIG_DIR}/~/"
     ;;
   esac
   
   chmod a+r "${TARGET_CONFIG_DIR}/~/$f" ||  echo "Warning: something went wrong during initialization of '${TARGET_CONFIG_DIR}/~/$f' out of '${SELFDIR}/templates/$f'!"
done 

## only files
cd "${TARGET_CONFIG_DIR}/~/"

touch md5 list descriptions

grep -Ei '^  ([a-z].*:| *- *"description *=.*")' ./docker-compose.yml | \
  grep -Ei -B1 'description *=' | \
    grep -vE '^--$' | \
      sed -e 's@^ *@@g' -e 's@^ *\([^ ]*\) *: *$@export \1_\\@g' -e 's@^ *- "\(description\) *=\(.*\)"@\1="\2"@g' > \
        "descriptions~"
chmod a+r "descriptions~" && mv "descriptions~" descriptions

if [ -r "${SSH_KEY}" ];
then

  ln -sf  "${SSH_KEY}" .
  cp -L --preserve=all "${SSH_KEY}.pub" ./id_rsa.pub

  cat >"ssh_config~" <<EOF
Host ${station_id}
  ForwardX11=no 
  StrictHostKeyChecking=no 
  BatchMode=yes 
  PasswordAuthentication=no 
  UserKnownHostsFile=/dev/null 
  LogLevel=quiet 
  ConnectionAttempts=3 
  ConnectTimeout=10 
  ControlMaster=no 
  ControlPath=none 
  IdentitiesOnly=yes 
  Compression yes
  HostName ${IP_ADDRESS}
  Port=${SSH_PORT}
  IdentityFile=`basename "${SSH_KEY}"`
# ${SSH_KEY}
  User=${SSH_USER}
EOF

  chmod go-rwx "ssh_config~" && mv "ssh_config~" ssh_config

  cat >"ssh_config~" <<EOF
Host ${station_id}
  ForwardX11=no 
  StrictHostKeyChecking=no 
  BatchMode=yes 
  PasswordAuthentication=no 
  UserKnownHostsFile=/dev/null 
  LogLevel=quiet 
  ConnectionAttempts=3 
  ConnectTimeout=10 
  ControlMaster=no 
  ControlPath=none 
  IdentitiesOnly=yes 
  Compression yes
  HostName ${IP_ADDRESS}
  Port=20
#  ${SSH_PORT}
  IdentityFile=`basename "${SSH_KEY}"`
  User=root
EOF

  chmod go-rwx "ssh_config~" && mv "ssh_config~" ssh_config.mng

fi

ls -1 | grep -vE '^(.*~|list)$' > "list~"
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 | grep -vE '^(md5|.*~)$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

mv --backup=existing -f -- ./* ../

cd .. && rmdir ./~/


cd "${BASE_DIR}/"
## TODO: only directories/stations
ls -1 | grep -vE '^(list|md5|supernova|.*~|[\.].*)$' > "list~" 
chmod a+r "list~" && mv "list~" list

md5sum `ls -1 */md5 | grep -vE '^[^/]*~/md5$'` > "md5~"
chmod a+r "md5~" && mv "md5~" md5

exit 0
