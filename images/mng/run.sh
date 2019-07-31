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

# configure nginx
: ${HILBERT_UI_EXT_PORT:=8000}
: ${HILBERT_UI_INT_PORT:=4000}
cat <<EOF > /etc/nginx/sites-enabled/hilbert-ui
server {
       listen       ${HILBERT_UI_EXT_PORT};
       server_name  localhost;

       location / {
           root   /usr/local/hilbert-ui/client/public;
           index index.html index.htm;
       }

       location /api/ {
               proxy_pass http://127.0.0.1:${HILBERT_UI_INT_PORT}/;
               proxy_redirect default;
               proxy_http_version 1.1;
               proxy_set_header Upgrade \$http_upgrade;
               proxy_set_header Connection 'upgrade';
               proxy_set_header Host \$host;
               proxy_cache_bypass \$http_upgrade;
       }

       error_page   500 502 503 504  /50x.html;
       location = /50x.html {
           root   html;
       }
}
EOF

/usr/local/nginx.sh || exit 1

: ${HILBERT_UI_SIMULATION_MODE:=0}
: ${HILBERT_UI_LOG_LEVEL:=info}
: ${HILBERT_UI_LOG_DIR:=./log}
: ${HILBERT_UI_OMD_POLL_DELAY:=1000}
: ${HILBERT_UI_POOL_TIMEOUT:=15}
: ${HILBERT_UI_OMD_CMD:=nc localhost 6557}
: ${HILBERT_UI_DB:=../work/db/hilbert-dev.sqlite}
: ${HILBERT_SERVER_CONFIG_PATH:=/HILBERT/}
: ${HILBERT_CLI_PATH:=/usr/local/bin}

cd /usr/local/hilbert-ui/server/

cat <<EOF
Starting Dashboard's Back-end Server [node app/main.js] (in [${PWD}]) with the following arguments:
  --test="${HILBERT_UI_SIMULATION_MODE}"
  --port="${HILBERT_UI_INT_PORT}"
  --log_level="${HILBERT_UI_LOG_LEVEL}"
  --log_directory="${HILBERT_UI_LOG_DIR}"
  --mkls_poll_delay="${HILBERT_UI_OMD_POLL_DELAY}"
  --long_poll_timeout="${HILBERT_UI_POOL_TIMEOUT}"
  --mkls_cmd="${HILBERT_UI_OMD_CMD}"
  --db_path="${HILBERT_UI_DB}"
  --hilbert_cfg="${HILBERT_SERVER_CONFIG_PATH}"
  --hilbert_cli="env LC_CTYPE=en_US.UTF-8 ${HILBERT_CLI_PATH}/hilbert"
  "$@"

$(env | grep HILBERT_)
EOF

# export NODE_PATH=/usr/lib/node_modules/hilbert-ui/node_modules
exec node lib/main.js \
  --test="${HILBERT_UI_SIMULATION_MODE}" \
  --port="${HILBERT_UI_INT_PORT}" \
  --log_level="${HILBERT_UI_LOG_LEVEL}" \
  --log_directory="${HILBERT_UI_LOG_DIR}" \
  --mkls_poll_delay="${HILBERT_UI_OMD_POLL_DELAY}" \
  --long_poll_timeout="${HILBERT_UI_POOL_TIMEOUT}" \
  --mkls_cmd="${HILBERT_UI_OMD_CMD}" \
  --db_path="${HILBERT_UI_DB}" \
  --hilbert_cfg="${HILBERT_SERVER_CONFIG_PATH}" \
  --hilbert_cli="env LC_CTYPE=en_US.UTF-8 ${HILBERT_CLI_PATH}/hilbert" \
  "$@"
