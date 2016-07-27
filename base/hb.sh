#!/bin/bash

if [ -z "${APP_ID}" ]; then
  exit 0
fi

### HB: SET VARS...
export HB_HOST=${HB_HOST:-localhost}
export HB_PORT=${HB_PORT:-8888}
export HB_URL="http://${HB_HOST}:${HB_PORT}"

CMD="$1"
shift

TIME="$1"
#  shift
##export >>/tmp/hb_sh_set
curl -s -L -XGET -- "${HB_URL}/${CMD}?${TIME}&appid=${APP_ID}"
# 2>/tmp/hb_sh_errs
