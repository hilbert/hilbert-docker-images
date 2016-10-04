mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := Xorg.sh startXephyr.sh
include ../Makefile.inc


RUNTERM=--ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw
# -v /dev/shm:/dev/shm -v /dev/dri:/dev/dri 

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=startXephyr.sh
# Xorg.sh

check: $(TS)
	echo "CMD: '${CMD}' '${ARGS}'"
	#	test -z "${DISPLAY}" || xhost + # -e DISPLAY
	docker run -d -e XCMD=Xvfb -e USER=root -e HOME=/root/  --name xxx ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD} -screen 0 1024x768x16
	sleep 4
	docker ps -a | grep xxx
	docker logs xxx 2>&1 | grep DISPLAY
	xterm -display `docker logs xxx 2>&1 | grep DISPLAY_NUM | sed s@DISPLAY_NUM@@g` -e bash -c 'docker logs xxx; sleep 9'
	docker rm -vf xxx
