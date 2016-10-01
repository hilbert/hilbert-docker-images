mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash

RUNTERM=-it -a stdin -a stdout -a stderr -P \
        --ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw 

### --label is_top_app=1

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	docker run --rm ${RUNTERM} $(IMG) ${OPTS} -- ${CMD}
