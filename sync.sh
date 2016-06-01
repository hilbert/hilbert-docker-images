#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "${SELFDIR}" && pwd`
cd "${SELFDIR}"

# set -e

CMS_HOST="${CMS_HOST:-dilbert}"

CMS="${CMS_HOST}"

### sftp:
CMS_URL="${CMS:-sftp://${CMS_HOST}}"
CMS_CONFIG_DIR="${CMS_CONFIG_DIR:-.config/dockapp/STATIONS}"

CACHE_DIR="${CACHE_DIR:-${SELFDIR}/STATIONS}"
# mkdir -p "${CACHE_DIR}"

DIR="$1"
[[ ! -z "${DIR}" ]] && DIR="/${DIR}"

## http://serverfault.com/questions/135618/is-it-possible-to-use-rsync-over-sftp-without-an-ssh-shell

# NOTE: requires lftp for file synchronization over sftp:
# http://lftp.yar.ru/lftp-man.html
# https://smyl.es/using-lftp-ftp-to-mirrortransfer-files-from-one-server-to-another/
# http://allanmcrae.com/2011/07/syncing-files-across-sftp-with-lftp/

#lftp -e "mirror -v --dry-run --scan-all-first -R -c -L '${CMS_CONFIG_DIR}${DIR}/' '${CACHE_DIR}${DIR}/'; bye" "${CMS_URL}"

# -n  dry-run!
rsync -rtbviuzP -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"  "${CACHE_DIR}${DIR}/" "${CMS_URL}:${CMS_CONFIG_DIR}${DIR}/"

# -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
#  -r, --recursive             recurse into directories
#  -l, --links                 copy symlinks as symlinks   ##### TODO: FIXME!
#  -p, --perms                 preserve permissions        ##### TODO: FIXME!
#  -g, --group                 preserve group              ##### TODO: FIXME!
#  -o, --owner                 preserve owner (super-user only)# TODO: FIXME!
#  -D                          same as --devices --specials
#    --devices               preserve device files (super-user only) # TODO!
#    --specials              preserve special files                  # TODO!
#  -t, --times                 preserve modification times

# -i turns on the itemized format, which shows more information than the default format
# -b makes rsync backup files that exist in both folders, appending ~ to the old file. You can control this suffix with --suffix .suf
# -u makes rsync transfer skip files which are newer in dest than in src
# -z turns on compression, which is useful when transferring easily-compressible files over slow links
# -P turns on --partial and --progress
#  --partial makes rsync keep partially transferred files if the transfer is interrupted
#  --progress shows a progress bar for each transfer, useful if you transfer big files

if [ $? -ne 0 ]; then
   echo "ERROR: cannot synchronize local cache ('${CACHE_DIR}${DIR}/') with CMS ('${CMS_URL}:${CMS_CONFIG_DIR}${DIR}/')..."
   exit 1
fi

#cmp CMS/md5 STATIONS/md5 || rsync -curltv CMS STATIONS/
exit 0





