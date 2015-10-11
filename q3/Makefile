mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash -c "setup_ogl.sh;/usr/games/openarena +set cg_drawFPS 1 +set cg_drawStatus 1 +timedemo 1 +set demodone 'quit' +set demoloop1 'demo demo088-test1; set nextdemo vstr demodone' +vstr demoloop1"

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}
