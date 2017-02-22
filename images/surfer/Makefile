mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=launch.sh /opt/SURFER/SURFER

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host
OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

build: build_full
