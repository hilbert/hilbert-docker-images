#!/usr/bin/env bash

__SELFDIR=`dirname "$0"`
__SELFDIR=`cd "${__SELFDIR}" && pwd`

declare -r station_id="$1"
declare -r app_id="$2"

if [[ -r /etc/container_environment.sh ]]; then 
  source /etc/container_environment.sh
fi

export HOME="${HOME:-/root}"
export HILBERT_CLI_PATH="${HILBERT_CLI_PATH:-${__SELFDIR}}"
export HILBERT_SERVER_CONFIG_PATH="${HILBERT_SERVER_CONFIG_PATH:-/HILBERT/Hilbert.yml}"

if [ -z "${HILBERT_CLI_PATH}" ]; then
    >&2 echo "The HILBERT_CLI_PATH environment variable is not set. Set it to the directory where 'hilbert' is installed!".
    exit 1
fi

if [ -z "${HILBERT_SERVER_CONFIG_PATH}" ]; then
    >&2 echo "The HILBERT_SERVER_CONFIG_PATH environment variable is not set. Set it to the path of 'Hilbert.yml'!".
    exit 1
fi

if [ ! -d "${HILBERT_CLI_PATH}" ]; then
    >&2 echo "'${HILBERT_CLI_PATH}' directory not found!"
    exit 1
fi

if [ ! -f "${HILBERT_CLI_PATH}/hilbert" ]; then
    >&2 echo "'hilbert' not found in '${HILBERT_CLI_PATH}'!"
    exit 1
fi

if [ ! -f "${HILBERT_SERVER_CONFIG_PATH}" ]; then
    >&2 echo "Hilbert Configuration file '${HILBERT_SERVER_CONFIG_PATH}' not found!"
    exit 1
fi

if [ ! -r "${HILBERT_SERVER_CONFIG_PATH}" ]; then
    >&2 echo "Hilbert Configuration file '${HILBERT_SERVER_CONFIG_PATH}' is unreadable!"
    exit 1
fi


if [ -z "${station_id}" ]; then
  >&2 echo "First argument missing: station_id."
  >&2 echo "Possible StationIDs according to '${HILBERT_SERVER_CONFIG_PATH}' are as follows: "
  "${HILBERT_CLI_PATH}/hilbert" -v list_stations --configfile "${HILBERT_SERVER_CONFIG_PATH}" --format list
  exit 1
fi

if [ -z "${app_id}" ]; then
  >&2 echo "Second argument missing: app_id."
  >&2 echo "App possible ApplicationIDs according to '${HILBERT_SERVER_CONFIG_PATH}' are as follows: "
  "${HILBERT_CLI_PATH}/hilbert" -v list_applications --configfile "${HILBERT_SERVER_CONFIG_PATH}"
  exit 1
fi

echo "Changing top app of station $station_id to $app_id"

"${HILBERT_CLI_PATH}/hilbert" -v app_change --configfile "${HILBERT_SERVER_CONFIG_PATH}" "${station_id}" "${app_id}"
declare -r last_rc=$?

if [ "$last_rc" -ne "0" ]; then
  echo >&2 "Changing top app of station $station_id cancelled."
  exit 1;
fi

echo "Finished changing top app of $station_id"
station_address=$("${HILBERT_CLI_PATH}/hilbert" -q cfg_query --configfile "${HILBERT_SERVER_CONFIG_PATH}" -c -f plain -o "Stations/${station_id}/address" | head -n 1)

## NOTE: Try to force OMD/CheckMK recheck of the altered station
sleep 2
echo "COMMAND [$(date +%s)] START_EXECUTING_SVC_CHECKS" | nc localhost 6557
sleep 2
echo "COMMAND [$(date +%s)] SCHEDULE_FORCED_SVC_CHECK;${station_id};Check_MK inventory;$(date +%s)" | nc localhost 6557
sleep 2
echo "COMMAND [$(date +%s)] SCHEDULE_FORCED_SVC_CHECK;${station_address};Check_MK inventory;$(date +%s)" | nc localhost 6557
#sleep 2
#echo "COMMAND [$(date +%s)] START_EXECUTING_SVC_CHECKS" | nc localhost 6557
sleep 2
echo "COMMAND [$(date +%s)] SCHEDULE_FORCED_SVC_CHECK;${station_id};Check_MK inventory;$(date +%s)" | nc localhost 6557
sleep 2
echo "COMMAND [$(date +%s)] SCHEDULE_FORCED_SVC_CHECK;${station_address};Check_MK inventory;$(date +%s)" | nc localhost 6557

exit 0
