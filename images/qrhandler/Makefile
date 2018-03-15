mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := action.sh event qrhandler.sh

include ../Makefile.inc

# TAG=titan.h-its.org:5555/${IMG}

QR_DEVICE_ID=AT Translated Set 2 keyboard
CMD=qrhandler.sh "${QR_DEVICE_ID}"

RUNTERM=-it -a stdin -a stdout -a stderr -P --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock

OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || true
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=0 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} || true
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	xinput reattach "${QR_DEVICE_ID}" "Virtual core keyboard"

build: build_full
