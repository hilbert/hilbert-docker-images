mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=bash
check: $(TS)
	docker run --rm ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

