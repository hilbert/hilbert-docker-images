mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := x11vnc.sh
include ../Makefile.inc


RUNTERM=-a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw

# -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri 

OPTS=--skip-startup-files --quiet --skip-runit

CMD=x11vnc.sh

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	echo "CMD: '${CMD}' '${ARGS}'"
	xhost + || exit 1
	docker ps -a
	docker run --rm -e XAUTHORITY -e DISPLAY ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD} ; echo $$? > .returncode
	cat .returncode && rm .returncode
