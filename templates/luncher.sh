#!/bin/sh
#
# Run docker-compose within 'ddd'
#
# This script will attempt to mirror the host paths by using volumes for the
# following paths:
#   * $(pwd)
#   * $(dirname $COMPOSE_FILE) if it's set
#   * $HOME if it's set
#
# You can add additional volumes (or any docker run options) using
# the $COMPOSE_OPTIONS environment variable.
#

## set -e

# echo $PWD

# echo "Args: "
# echo "["
# echo "$@"
# echo "]"

# export 

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$HOME/.config/dockapp"
fi

cd $CFG_DIR

# ls -la 

if [ -r "./station.cfg" ]; then
    . "./station.cfg"
fi

if [ -r "./startup.cfg" ]; then
    . "./startup.cfg"
fi

if [ -r "./lastapp.cfg" ]; then
    . "./lastapp.cfg"
fi

if [ -r "./docker.cfg" ]; then
    . "./docker.cfg"
fi

if [ -r "./compose.cfg" ]; then
    . "./compose.cfg"
fi

if [[ -f ./compose ]];
then
  if [[ ! -x ./compose ]];
  then
     chmod -f a+x ./compose
  fi
  
  if [[ ! -x ./compose ]];
  then
     sudo -n -P chmod -f a+x ./compose
  fi

  if [[ -x ./compose ]];
  then
     # --no-build --no-color 
     exec ./compose "$@"
  else
     echo "Warning: could not make '${CFG_DIR}/compose' into an executable: "
     ls -la ${CFG_DIR}/compose
  fi
fi

if hash docker-compose 2>/dev/null; 
then
  exec docker-compose "$@"
fi

echo "ERROR: Sorry no executable '${CFG_DIR}/compose' or global docker-compose on the system!"
exit 1
