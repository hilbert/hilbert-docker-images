mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := skype.sh apulse/libpulse-simple.so apulse/libpulse-simple.so.0 apulse/libpulse.so apulse/libpulse.so.0 apulse/libpulsecommon-5.0.so
include ../Makefile.inc

CMD=skype.sh

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 $(IMG) ${OPTS} -- ${CMD}


