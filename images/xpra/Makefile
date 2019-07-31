mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

IMAGE_VERSION := test1

#APP=kiosktest
# IMG  = ${U}/${APP}:${IMAGE_VERSION}

TAG=es-ex.hq.eso.org:5555/${IMG}

# titan.h-its.org:5555/hits/moon:${IMAGE_VERSION:-latest}

RUNTERM=-a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw

# -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri 

OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

CMD=bash 
# xpra


check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	echo "CMD: '${CMD}' '${ARGS}'"
	xhost + || exit 1
	docker ps -a
	docker run --rm -e XAUTHORITY -e DISPLAY ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD} ; echo $$? > .returncode
	cat .returncode && rm .returncode

build: build_full
