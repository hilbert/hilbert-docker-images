mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash

RUNTERM=-it -a stdin -a stdout -a stderr -P \
        --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw 

### --label is_top_app=1

OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	docker run --rm ${RUNTERM} $(IMG) ${OPTS} -- ${CMD}
