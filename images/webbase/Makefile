mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=launch.sh 
ARGS=

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host
OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -la /dev/pts/ptmx
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	ls -la /dev/pts/ptmx
