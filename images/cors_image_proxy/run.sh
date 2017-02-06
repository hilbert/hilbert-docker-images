#!/usr/bin/env bash

if [[ -r /etc/container_environment.sh ]]; then 
  source /etc/container_environment.sh
fi

exec /usr/local/src/cors_proxy/cors.sh $@
