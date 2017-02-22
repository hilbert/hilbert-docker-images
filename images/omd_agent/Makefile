mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=bash -c 'omd_agent_entrypoint.sh'
# ARGS= 
# telnet localhost 6556 
### --privileged 
RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock -p 6556:6556 -p 8888:8888

### TODO: switch to remote docker / networking!?

OPTS=/sbin/my_init --skip-startup-files --skip-runit 

check: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 $(IMG) ${OPTS} -- ${CMD}


build: build_full
