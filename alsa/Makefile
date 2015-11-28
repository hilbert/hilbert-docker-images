mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := soundtest.sh .asoundrc
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr --privileged
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=soundtest.sh

check: $(TS)
	docker run -e DISPLAY --rm ${RUNTERM} --label is_top_app=1 --net=none -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

