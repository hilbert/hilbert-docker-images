#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`
cd "${SELFDIR}/"

### set -e
## unset DISPLAY

#! NOTE: cleanup all previously started containers:
# docker ps -aq | xargs docker rm -fv

if [ -r "./station.cfg" ]; then
    . "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    . "./startup.cfg"
fi

station_default_app="${station_default_app:-$default_app}"

if [ -r "/tmp/lastapp.cfg" ]; then
    . "/tmp/lastapp.cfg"
else
    export current_app="${station_default_app}"
fi

for d in ${background_services}; do
  echo "Starting Background Service: '${d}'..."
  "./luncher.sh" up -d "${d}"
done

echo "Front GUI Application: '${current_app}'..."

if [ -n "${current_app}" ]; then
  echo "export current_app='${current_app}'" > "/tmp/lastapp.cfg.new~"
  "./luncher.sh" up -d "${current_app}"
  mv "/tmp/lastapp.cfg.new~" "/tmp/lastapp.cfg"
fi
