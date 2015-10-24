mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=launch.sh 
ARGS=/usr/local/src/Deflectouch/run.sh
## bash -c 'setup_ogl.sh && cd /usr/local/src/Deflectouch/ && python main.py'

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run --rm -e DISPLAY ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
