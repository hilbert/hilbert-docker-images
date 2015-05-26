mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := soundtest.sh
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr --privileged
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=soundtest.sh
check: $(TS)
	docker run --rm ${RUNTERM} --net=none -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

