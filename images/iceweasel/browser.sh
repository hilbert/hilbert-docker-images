#! /bin/bash

ARGS=$@
## FIXMEL fullscreen may not work :(
[ -z "${ARGS}" ] && ARGS="-url http://localhost:8080/"
# -fullscreen
exec firefox.sh ${ARGS}
