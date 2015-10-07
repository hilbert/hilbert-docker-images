mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := x11comp.sh
include ../Makefile.inc

CMD=x11comp.sh xterm -e bash -c 'ps aux; sleep 9'

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY -e MOUSE_CURSOR=off ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

