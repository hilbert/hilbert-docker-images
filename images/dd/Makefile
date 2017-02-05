mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=docker ps -a

# --ipc=host --privileged --net=host --pid=host 

RUNTERM=-it -a stdin -a stdout -a stderr -P \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock

#	-e DOCKER_HOST=unix:///var/run/docker.sock -e NO_PROXY=/var/run/docker.sock
##        --add-host=dockerhost:$HIP 

### TODO: switch to remote docker / networking!?

OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	docker ps -a
	docker run --rm ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD}

