mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=--skip-startup-files --skip-runit

# CMD=bash
CMD=/DOCKAPP/run.sh

## COPY dockapp_dashboard /usr/local/dockapp_dashboard
check: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=0 -v "/tmp/:/tmp/:rw" -v "${PWD}:/DOCKAPP:rw" -v "${HOME}/.ssh:/root/.ssh:ro"  -v "${HOME}:${HOME}:ro" -v "${PWD}/dockapp_dashboard:/usr/local/dockapp_dashboard:ro" -p 8081:8080 $(IMG) ${OPTS} -- ${CMD}

