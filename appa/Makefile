mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := A.sh
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=A.sh 
ARGS=AHelloA

check: $(TS)
	docker run --rm ${RUNTERM} --net=none $(IMG) ${OPTS} -- ${CMD} ${ARGS}

