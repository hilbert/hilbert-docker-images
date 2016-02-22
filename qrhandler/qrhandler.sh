#!/bin/bash

# NOTE: just for testing:
### gcc --static event.c -o event || exit 1

OLDDIR="${PWD}"
SELFDIR=`dirname "$0"`
cd "${SELFDIR}"

N="$1"
N="${N:-${QR_DEVICE_ID}}"
N="${N:-AT Translated Set 2 keyboard}"

echo "Device: '${N}'..." 1>&2

ID=`xinput list "${N}" | grep -iE '\W*id=([0-9]*)\W*\[.*slave' | sed -e 's|.*id=||ig' -e 's|\W.*$||ig'`

# xargs -n 1 -I '{}' 
echo "Device ID: '${ID}' with props and state:" 1>&2
xinput list-props "$ID" 1>&2 || exit 1
xinput query-state "$ID" 1>&2 || exit 1

EV=`xinput list-props "$ID" | grep '/dev/input/event' | sed -e 's@^.*"\(.*\)"@\1@g'`

xinput float "$ID"  1>&2 || exit 1

# | xargs -n 1 -I '{}' 

echo "Device Event File: '${EV}' with description: " 1>&2 
evemu-describe "$EV" 1>&2 || exit 1

./event "$EV" | xargs -n 1 -L 1 --no-run-if-empty -I '{}' ./action.sh '{}'

cd "${OLDDIR}"
