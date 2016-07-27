#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e
## unset DISPLAY
cd "${SELFDIR}/"

if [ -r "./station.cfg" ]; then
    source "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    source "./startup.cfg"
fi

if [ -r "/tmp/lastapp.cfg" ]; then
    source "/tmp/lastapp.cfg"
    old="${current_app}"
    unset current_app
    mv -f "/tmp/lastapp.cfg" "/tmp/lastapp.cfg.bak"
else
    old="${default_app}"
fi

"./luncher.sh" stop -t 10 "${old}"
"./luncher.sh" kill -s SIGTERM  "${old}"
"./luncher.sh" kill -s SIGKILL  "${old}"
"./luncher.sh" rm -f "${old}"
unset old

#### ARGUMENT!!!
export current_app="$@"
echo "export current_app='${current_app}'" > "/tmp/lastapp.cfg.new~"
"./luncher.sh" up -d "$current_app" && mv -f "/tmp/lastapp.cfg.new~" "/tmp/lastapp.cfg"
