mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../../../Makefile.inc

# RUNTERM=-it -a stdin -a stdout
OPTS=
CMD=bash

RUNTERM=-it -a stdin -a stdout -a stderr \
        --ipc=host --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v "/tmp/:/tmp/:rw" \
        -v "${PWD}:/DOCKAPP2:rw" \
        -v "${HOME}:${HOME}:ro"

check: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD}

