mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := ptmx.sh
include ../Makefile.inc

CMD=ptmx.sh
ARGS=

RUNTERM=-a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock -P

### TODO: switch to remote docker / networking!?

OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run --rm ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx

