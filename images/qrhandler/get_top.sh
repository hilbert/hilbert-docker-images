#! /usr/bin/env bash
# for emacs: -*-sh-*-

# Author: Oleksandr Motsak <malex984+get.top.sh@gmail.com>
#
# The script checks if a single frontent container/app is running. And outputs its APP_ID to STDOUT.
#
# Possible exit codes:
# 0: OK. 
#    A single running top app (same data from HeartBeat server and Docker Engine).
#
# 1: WARNING. 
#    None or multiple apps or incompatible reports from HeartBeat Server and Docker Engine. 
# NOTE: STDOUT may be empty or a comma-separated list of (several) APP_IDs according to Docker Engine
# NOTE: if HeartBeat reports a single app - it will be trusted over Docker Engine. 
# NOTE: if situation is too confusing - detailed warning will be in STDERR 
#
# 2: ERROR
#    Could not query Heartbeat server or Docker Engine. 
# NOTE: STDOUT is empty. Error message is in STDERR

COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-hilbert}" 

function OK()
{
  msg="$@"
  echo "${msg}"  # OK - 
  exit 0
}

function WARNING()
{
  msg="$@"
  echo "${msg}" # WARNING - 
  exit 1
}

function ERROR()
{
  msg="$@"
  echo "${msg}" 1>&2 # CRITICAL - 
  exit 2
}

function bashjoin() 
{ 
  local IFS="$1"
  shift
  echo "$*"
}


####################################################################

### Following heartbeat2.py/heartbeat3.py
export PORT_NUMBER=${HB_PORT:-8888}
export HOST_NAME=${HB_HOST:-127.0.0.1}
export DEFAULT_URL="http://${HOST_NAME}:${PORT_NUMBER}"
export HB_URL=${HB_URL:-$DEFAULT_URL}


#! Main HB Status Query:
HB=$(curl -s -X GET "${HB_URL}/status" 2>&1)
##echo "[$HB]"

if [[ $? -ne 0 || -z "${HB}" ]]; then
    ERROR "Couldnot get local heartbeat status"
fi

## "UNKNOWN -  no heartbeat clients yet..."
NOPE="^UNKNOWN - *no heartbeat clients yet"
if [[ ${HB} =~ $NOPE ]]; then
    ERROR "$HB"
fi

declare -i HB_COUNT="1"

## "WARNING - multiple (" + str(len(visits)) + ") applications"
MULTIPLE="^WARNING - multiple [\(]([0-9]+)[\)] applications"
if [[ ${HB} =~ $MULTIPLE ]]; then
    HB_COUNT="${BASH_REMATCH[1]}"
fi

declare HB_APP_ID=""

## "OK - fine application [" + str(ID) + "]| od=" + str(od) + ";1;3;0;10 delay=" + str(dd) + ";;; "
## "WARNING - somewhat late application [" + str(ID) + "]| od=" + str(od) + ";1;3;0;10 delay=" + str(dd) + ";;; "
## "CRITICAL - somewhat late application [" + str(ID) + "]| od=" + str(od) + ";1;3;0;10 delay=" + str(dd) + ";;; "

HB_APP_REG=" application \[ *([^ ]+) *[@]"
if [[ ${HB} =~ $HB_APP_REG ]]; then
    HB_APP_ID="${BASH_REMATCH[1]}"
fi

####################################################################
export DOCKER=${DOCKER:-docker}

declare -a TOP=($(${DOCKER} ps -a -q \
    --filter "label=is_top_app=1" \
    --filter "label=com.docker.compose.project=${COMPOSE_PROJECT_NAME}" \
    --filter "status=running" 2>/dev/null ))

if [[ $? -ne 0 ]]; then
    ERROR "Could not query Docker Engine via ${DOCKER}!"
fi

declare -g ENV_APP_REG="( |\[)APP_ID=([^ ]*)( |\])"

function get_APP_ID() {
    local cont="$1"
    local E=$(${DOCKER} inspect --format='{{index .Config.Env }}' "${cont}" 2>/dev/null)

    if [[ $? -ne 0 ]]; then
        echo "Could not inspect $ind-th container '$cont'"
	return 1
    fi

    if [[ $E =~ $ENV_APP_REG ]]; then 
#        echo "${BASH_REMATCH[@]}"
	echo "${BASH_REMATCH[2]}"
	return 0
    else
        echo "Container '$cont' contains no APP_ID env.var!"
	return 1
    fi

}

for ind in ${!TOP[@]}; 
do
    ID=$(get_APP_ID "${TOP[$ind]}")

    if [[ $? -eq 0 ]]; then
    	TOP[$ind]="${ID}"
    else
	unset TOP[$ind]
    fi
done

# declare -p TOP

declare -i N=${#TOP[@]}
declare M=$(bashjoin ',' ${TOP[@]})


####################################################################
# NOTE: By design there must be a single top (GUI) application!

if [[ $N -eq 1 && "${HB_COUNT}" -eq $N && "x${HB_APP_ID}" = "x${M}" ]]; then
#    echo "Found 1 top application!"
    OK "${HB_APP_ID}"
fi

if [[ $N -eq 0 && "${HB_COUNT}" -eq $N && -z "${HB_APP_ID}" && -z "${M}" ]]; then
#    echo "Found no top application!"
    WARNING ""
fi

if [[ "${HB_COUNT}" -eq $N && -z "${HB_APP_ID}" && -n "${M}" ]] ; then
#    echo "Found $N top applications :("
    WARNING "${M}"  # NOTE: comma-separated list of APP_IDs
fi

echo "Local HeartBeat server reports ${HB_COUNT} top apps. while Docker Engine $N apps: $M" 1>&2

# 1st order fall-back: HeartBeat server
if [[ "${HB_COUNT}" -eq 1 && -n "${HB_APP_ID}" ]] ; then
    WARNING "${HB_APP_ID}"
fi

# Last fall-back: Docker Engine
WARNING "${M}"

#exit 2

