mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

TERM_OPTS=-it -a stdin
RUNTERM=-a stdout -a stderr ${TERM_OPTS} \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock \
        --privileged --ipc=host --net=host --pid=host \
        -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock

CMD= -c 'docker info'

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	docker ps -a
	docker run --rm ${RUNTERM} --label is_top_app=0 --entrypoint=bash $(IMG) ${CMD}

#@touch ${XAUTH}
#@xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
