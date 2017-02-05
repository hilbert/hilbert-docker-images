mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --quiet --skip-runit

CMD=bash -c 'setup_ogl.sh /tmp/OGL.tgz; echo "Sleeping..."; sleep 3; echo "All is done!"'
check: $(TS)
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

