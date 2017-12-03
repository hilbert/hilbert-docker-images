mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=/opt/dune-ash.sh
ARGS=

## --privileged
RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host -v /tmp/:/tmp/:rw -v /dev/dri/:/dev/dri/:rw
OPTS=
# /sbin/my_init --skip-startup-files --quiet --skip-runit --

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	$(DOCKER) run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 $(IMG) ${OPTS} ${CMD} ${ARGS} || true
	ls -al /dev/pts/ptmx
	: chmod a+rw /dev/pts/ptmx

build: build_full
