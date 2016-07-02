#!/usr/bin/env bash

if [ "$1" = "" ]; then
echo "Usage: $0 <path to dockapp>"
exit 1
fi

print_station()
{
  root_path=$1
  station_name=$2

  unset station_id
  unset station_type
  unset CFG_DIR
  unset background_services
  unset default_app
  unset possible_apps
  unset DM

  source $1/STATIONS/$station_name/station.cfg
  source $1/STATIONS/$station_name/startup.cfg

  echo "{"
  echo "\"id\": \"$station_id\","
  echo "\"name\": \"$station_name\","
  echo "\"type\": \"$station_type\","
#  echo "\"cfg_dir\": \"$CFG_DIR\","
#  echo "\"background_services\": \"$background_services\","
  echo "\"default_app\": \"$default_app\","

  echo "\"possible_apps\": ["
  local first=1
  for possible_app in $possible_apps; do
    if [ "$first" -eq "1" ]; then
      first=0
    else
      echo ","
    fi
    echo -n "\"$possible_app\""
  done
  echo ""
  echo "]"

#  echo "\"DM\": \"$DM\""
  echo "}"

  unset station_id
  unset station_type
  unset CFG_DIR
  unset background_services
  unset default_app
  unset possible_apps
  unset DM
}

echo "{"

echo "\"stations\": ["

first=1
for station_name in $(cat $1/STATIONS/list | grep -v -E '^ *(#.*)? *$') ; do
  if [ "$first" -eq "1" ]; then
    first=0
  else
    echo ","
  fi
  print_station $1 $station_name
done

echo "]"
echo "}"
