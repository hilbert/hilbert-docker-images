mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := main.sh menu.sh run.sh sv.sh A.sh
include ../Makefile.inc

CMD=main.sh
ARGS=

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock
##        --add-host=dockerhost:$HIP

### TODO: switch to remote docker / networking!?

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	docker ps -a
	docker run --rm ${RUNTERM} $(IMG) ${OPTS} -- ${CMD} ${ARGS}

