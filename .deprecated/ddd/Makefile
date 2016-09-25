mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := luncher.sh
include ../Makefile.inc

TERM_OPTS=-it -a stdin -a stdout -a stderr
RUNTERM=${TERM_OPTS} -v ${PWD}/../:/DOCKAPP -e CFG_DIR=/DOCKAPP \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock

#         --privileged --ipc=host --net=host --pid=host 

CMD=version

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	docker ps -a
	docker run --rm ${RUNTERM} --label is_top_app=0 $(IMG) ${CMD}
