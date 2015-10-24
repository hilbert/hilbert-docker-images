mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := demo.sh
include ../Makefile.inc

CMD=demo.sh
ARGS=

# -it -a stdin 
RUNTERM=-a stdout -a stderr --ipc=host --privileged --net=host --pid=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock -P

### TODO: switch to remote docker / networking!?

OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

check: $(TS)
	test -n "${DISPLAY}"
	test -z "${DISPLAY}" || xhost +
	docker ps -a
	docker run --rm -e MENU_TRY="gui" -e DISPLAY ${RUNTERM} $(IMG) ${OPTS} -- ${CMD} ${ARGS}

