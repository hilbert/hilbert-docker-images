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

if [ -r "./lastapp.cfg" ]; then
    source "./lastapp.cfg"
    old="${current_app}"
    unset current_app
    mv -f "./lastapp.cfg" "./lastapp.cfg.bak"
else
    old="${default_app}"
fi

"./luncher.sh" stop  "${old}"
"./luncher.sh" kill  "${old}"
"./luncher.sh" rm -f "${old}"
unset old

#### ARGUMENT!!!
export current_app="$@"
echo "export current_app='${current_app}'" > "./lastapp.cfg.new~"
"./luncher.sh" up -d "$current_app" && mv -f "./lastapp.cfg.new~" "./lastapp.cfg"
