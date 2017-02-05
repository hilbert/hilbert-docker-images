mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := main.sh menu.sh run.sh runback.sh sv.sh A.sh
include ../Makefile.inc

CMD=main.sh
ARGS=

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host \
        -v /etc/localtime:/etc/localtime:ro -v /tmp/:/tmp/:rw \
        -v /var/run/docker.sock:/var/run/docker.sock
	# -P

### TODO: switch to remote docker / networking!?

OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

check: $(TS)
	test -n "${DISPLAY}"
	test -z "${DISPLAY}" || xhost +
	docker ps -a
	docker run --rm -e MENU_TRY="text" -e DISPLAY ${RUNTERM} --label is_top_app=0 $(IMG) ${OPTS} -- ${CMD} ${ARGS}

