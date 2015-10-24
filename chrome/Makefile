mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=launch.sh browser.sh

## ## --make-default-browser
## --enable-kiosk-mode --kiosk --disable-new-kiosk-ui
ARGS=

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run --rm -e DISPLAY ${RUNTERM} -v /tmp/:/tmp/:rw -v /dev/shm:/dev/shm $(IMG) ${OPTS} -- ${CMD} ${ARGS} || true
	ls -al /dev/pts/ptmx
	: chmod a+rw /dev/pts/ptmx
