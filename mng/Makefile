mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr -p 8081:8080
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=bash

check: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=0 -v /tmp/:/tmp/:rw -v "${PWD}:/DOCKAPP:rw"  -v "${HOME}/.ssh:/root/.ssh"  -v "${HOME}/.docker:/root/.docker" $(IMG) ${OPTS} -- ${CMD}

