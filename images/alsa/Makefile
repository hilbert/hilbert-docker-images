mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --quiet --skip-runit

CMD=soundtest.sh

check: $(TS)
	docker run -e DISPLAY --rm ${RUNTERM} --label is_top_app=1 --net=none -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

