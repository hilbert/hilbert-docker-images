#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

### set -e
## unset DISPLAY

cd "${SELFDIR}/"

if [ -r "./station.cfg" ]; then
    . "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    . "./startup.cfg"
fi

if [ -r "./lastapp.cfg" ]; then
    . "./lastapp.cfg"
else
    export current_app="${default_app}"
fi

### TODO: detect docker settings
if [ -r "./docker.cfg" ]; then
    . "./docker.cfg"
fi

### TODO: detect audio/video settings
if [ -r "./compose.cfg" ]; then
    . "./compose.cfg"
fi

for d in ${background_services}; do
  echo "Starting Background Service: '${d}'..."
  "./luncher.sh" up -d "${d}"
done

echo "Front GUI Application: '${current_app}'..."

if [ -n "${current_app}" ]; then
  echo "export current_app='${current_app}'" > "./lastapp.cfg.new~"
  "./luncher.sh" up -d "${current_app}"
  mv "./lastapp.cfg.new~" "./lastapp.cfg"
fi
