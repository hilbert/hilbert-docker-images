#!/usr/bin/env bash

if [[ -r /etc/container_environment.sh ]]; then 
  source /etc/container_environment.sh
fi

## export >> /tmp/list_vars0

[[ -z "${HOME}" ]] && export HOME=/root

if [[ ! -d "${HOME}/.ssh" ]]; then 
  mkdir -p "${HOME}/.ssh"
  if [[ -d "${HILBERT_SERVER_CONFIG_SSH_PATH}" ]]; then 
##    ls -la "${HILBERT_SERVER_CONFIG_SSH_PATH}/"
    cd "${HILBERT_SERVER_CONFIG_SSH_PATH}" && cp -R -P -p -t "${HOME}/.ssh/" ./* && cd -
  fi
fi

# ls -la "${HOME}/.ssh/"

## set -v
## set -x 

/usr/local/nginx.sh || exit 1

exec /usr/local/uiserver.sh $@
