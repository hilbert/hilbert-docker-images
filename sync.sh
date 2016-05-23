#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "${SELFDIR}" && pwd`
cd "${SELFDIR}"

# set -e

CMS="${CMS:-sftp://dilbert}"
CMS_CONFIG_DIR="${CMS_CONFIG_DIR:-.config/dockapp/STATIONS}"

CACHE_DIR="${CACHE_DIR:-${SELFDIR}/STATIONS}"
# mkdir -p "${CACHE_DIR}"

DIR="$1"
[[ ! -z "${DIR}" ]] && DIR="/${DIR}"

# NOTE: requires lftp for file synchronization over sftp:
lftp -e "mirror --scan-all-first -c -v -L '${CMS_CONFIG_DIR}${DIR}' '${CACHE_DIR}${DIR}'; bye" "${CMS}"

if [[ $? -ne 0 ]]; then
   echo "ERROR: cannot synchronize '${CACHE_DIR}${DIR}' with CMS ('${CMS_CONFIG_DIR}${DIR}' at '${CMS}') via lftp mirroring!"
   exit 1
fi

#cmp CMS/md5 STATIONS/md5 || rsync -curltv CMS STATIONS/
exit 0





