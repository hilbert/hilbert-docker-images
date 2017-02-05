mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := x11comp.sh
include ../Makefile.inc

CMD=x11comp.sh xterm -e bash -c 'ps aux; sleep 9'

RUNTERM=-a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY -e MOUSE_CURSOR=off ${RUNTERM} --label is_top_app=0 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

