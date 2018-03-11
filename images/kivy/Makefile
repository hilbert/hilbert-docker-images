mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=launch.sh 
ARGS=bash -c "setup_ogl.sh;/usr/local/src/Deflectouch/run.sh"
## bash -c 'setup_ogl.sh && cd /usr/local/src/Deflectouch/ && python main.py'

PA_SETTING= -v "/run/user/`id -u`/pulse:/run/pulse" -e PULSE_SERVER=/run/pulse/native \
            -v ${HOME}/.config/pulse/cookie:/run/pulse_cookie -e PULSE_COOKIE=/run/pulse_cookie

RUNTERM=--rm -it -a stdin -a stdout -a stderr --ipc=host \
        --net=host -e DISPLAY -v /tmp/:/tmp/:rw ${PA_SETTING} $(VIDEO_DEVICES) $(AUDIO_DEVICES)

## --privileged
#RUNTERM=--rm -it -a stdin -a stdout -a stderr --net=host -v /tmp/:/tmp/:rw -e DISPLAY 


OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx
	: chmod a+rw /dev/pts/ptmx
	docker run ${RUNTERM} --label is_top_app=1 $(IMG) ${OPTS} -- ${CMD} ${ARGS}
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx

build: build_full
