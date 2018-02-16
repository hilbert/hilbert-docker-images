#!/usr/bin/env bash

__SELFDIR=`dirname "$0"`
__SELFDIR=`cd "${__SELFDIR}" && pwd`

## export >> /tmp/list_vars1

if [[ -r /etc/container_environment.sh ]]; then 
  source /etc/container_environment.sh
fi

## export >> /tmp/list_vars2

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

exec "${HILBERT_CLI_PATH}/hilbert" -q cfg_query --configfile "${HILBERT_SERVER_CONFIG_PATH}" --format json --compact --object 'Profiles/all'
