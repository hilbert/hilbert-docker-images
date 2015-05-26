mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := Xorg.sh startXephyr.sh
include ../Makefile.inc


RUNTERM=--ipc=host --privileged --net=host --pid=host
# -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri 
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=startXephyr.sh

check: $(TS)
	if [ -z "${DISPLAY}" ]; then \
		CMD=Xorg.sh Xorg ; \
	fi 
	echo "CMD: '${CMD}'"
	docker run --name xxx -e DISPLAY ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} /tmp/id xterm
	docker rm -vf xxx

