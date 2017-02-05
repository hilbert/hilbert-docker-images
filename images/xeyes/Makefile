mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

CMD=xterm

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD} ; echo $$? > .returncode
	cat .returncode && rm .returncode
