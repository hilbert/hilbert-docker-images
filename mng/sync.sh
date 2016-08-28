#!/bin/bash

SELFDIR=`dirname "$0"`
SELFDIR=`cd "${SELFDIR}" && pwd`

# cd "${SELFDIR}"

# set -e
# there should be ssh passwordless access configured (e.g. via ~/.ssh/config and key IDs)

CMS_HOST="${CMS_HOST:-supernova}"

### ssh:  # test sftp for now
# CMS="${CMS_HOST}"

### sftp:
CMS_URL="${CMS:-sftp://${CMS_HOST}}"
CMS_CONFIG_DIR="${CMS_CONFIG_DIR:-.config/dockapp/STATIONS}"

### local cache path:
CACHE_DIR="${CACHE_DIR:-${SELFDIR}/STATIONS}"

mkdir -p "${CACHE_DIR}"

DIR="$1"
if [ ! -z "${DIR}" ]; then 
#   DIR="/${DIR}/"
   CMS_CONFIG_DIR="${CMS_CONFIG_DIR}/${DIR}"
   CACHE_DIR="${CACHE_DIR}/${DIR}"
   echo "Synchronizing a single config dir of local cache ('${CACHE_DIR}') with remote CMS ('${CMS_URL}:${CMS_CONFIG_DIR}'): "
else
   echo "Synchronizing the whole local cache ('${CACHE_DIR}') with remote CMS ('${CMS_URL}:${CMS_CONFIG_DIR}'): "
fi


if [ -d "${CACHE_DIR}/${CMS_HOST}" ]; then 
   echo "Using auth from ${CACHE_DIR}/${CMS_HOST}/*.cfg"
   cd "${CACHE_DIR}/${CMS_HOST}"
      [ -r ./startup.cfg ] && source ./startup.cfg
      [ -r ./station.cfg ] && source ./station.cfg
      [ -r ./access.cfg  ] && source ./access.cfg
   cd -
fi


if [ -z "${CMS}" ]; then
   # sftp: get newest from CMS only:
   # --dry-run 
   echo "Sync via 'lftp -c \"set sftp:connect-program \\\"ssh -a -F /dev/null ${SSH_OPTS}\\\"; connect ${CMS_URL}; mirror --loop -v --scan-all-first --depth-first -c -L -x '~$' '${CMS_CONFIG_DIR}' '${CACHE_DIR}'; bye\"'..."
   lftp -c "set sftp:connect-program \"ssh -a -F /dev/null ${SSH_OPTS}\"; connect ${CMS_URL}; mirror --loop -v --depth-first -c -L -x '~$' '${CMS_CONFIG_DIR}' '${CACHE_DIR}'; bye"
   # --scan-all-first
else
   # ssh/scp/rsync: sync both CMS and local cache!
   # -n 
   echo "Sync via 'rsync -crtbviuzpP -e \"ssh -a -F /dev/null ${SSH_OPTS}\"  \"${CACHE_DIR}/\" \"${CMS_URL}:${CMS_CONFIG_DIR}/\"'..."
   rsync -crtbviuzpP -e "ssh -a -F /dev/null ${SSH_OPTS}"  "${CACHE_DIR}/" "${CMS_URL}:${CMS_CONFIG_DIR}/"
   ### TODO: FIXME: does not work ATM (supernova) 
fi

if [ $? -ne 0 ]; then
   echo "ERROR: cannot synchronize local cache ('${CACHE_DIR}') with CMS ('${CMS_URL}:${CMS_CONFIG_DIR}')..."
   exit 1
fi

### TODO: update/check the local result of sync?
#cmp CMS/md5 STATIONS/md5 || rsync -curltv CMS STATIONS/
exit 0





#########################################################################################################
## References:

#### sftp related links:

# http://serverfault.com/questions/135618/is-it-possible-to-use-rsync-over-sftp-without-an-ssh-shell

## sftp:
# http://www.computerhope.com/unix/sftp.htm

# NOTE: requires lftp for file synchronization over sftp:
# http://lftp.yar.ru/lftp-man.html
# https://smyl.es/using-lftp-ftp-to-mirrortransfer-files-from-one-server-to-another/
# http://allanmcrae.com/2011/07/syncing-files-across-sftp-with-lftp/

#########################################################################################################

#### rsync MAN:
# http://linux.die.net/man/1/rsync
# -c, --checksum
# -n  dry-run!
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

# -p, --perms
