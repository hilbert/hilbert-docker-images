mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=hb_wrapper.sh launch.sh hb_preload.sh run.sh -vvvvdim
# http://127.0.0.1:8080/
# hb_kiosk.sh
# https://ix.de
# hb_kiosk.sh
ARGS=

# APP=kiosktest
# IMG  = ${U}/${APP}:${IMAGE_VERSION}
# TAG=titan.h-its.org:5555/${IMG}
# titan.h-its.org:5555/hits/moon:${IMAGE_VERSION:-latest}
# VIDEO_DEVICES=`find /dev/ -group video -type c -exec echo -n "--device {} " \; 2>/dev/null`

# --ipc=host
# -v /dev/shm:/dev/shm:rw
# --device /dev/dri/card1
# --privileged
RUNTERM=--rm -it -a stdin -a stdout -a stderr --net=host -v /tmp/:/tmp/:rw -e DISPLAY $(VIDEO_DEVICES)

# --device /dev/dri/card1 --device /dev/dri/renderD129 
# -e KIOSK_BROWSER="/opt/kiosk-browser/kiosk-browser"
# in ms

OPTS=/sbin/my_init --skip-startup-files --skip-runit

#! 
build: build_full
 
check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	###: xhost + || exit 1
	xhost "+si:localuser:${USER}" || exit 1
	xhost +si:localuser:root || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run $(RUNTERM) -e APP_ID="hb_kiosk_browser_checking" -e HB_URL="http://127.0.0.1:8888" -e HB_SEND_INIT="false" -e HB_SEND_DONE="false" -e HB_PING_INTERVAL="5000" --label is_top_app=1 $(IMG) ${OPTS} -- ${CMD} ${ARGS} || true
	ls -al /dev/pts/ptmx
	xhost -si:localuser:root || exit 1
	xhost "-si:localuser:${USER}" || exit 1
	: chmod a+rw /dev/pts/ptmx
