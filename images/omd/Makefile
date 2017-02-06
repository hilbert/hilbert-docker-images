mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

# --privileged 
RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw -P

OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit
# --no-kill-all-on-exit --quiet

CMD=bash -c 'omd status; sleep 1; omd start; omd config default show; sleep 5; omd status; sleep 1; omd stop'
check: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD}

