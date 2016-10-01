mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := action.sh event qrhandler.sh

include ../Makefile.inc

CMD=qrhandler.sh
QR_DEVICE_ID=AT Translated Set 2 keyboard

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || true
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=0 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} "${QR_DEVICE_ID}" || true
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	xinput reattach "${QR_DEVICE_ID}" "Virtual core keyboard"
