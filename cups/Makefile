mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := \
etc-cups/cups-browsed.conf \
etc-cups/cupsd.conf \
etc-cups/cups-files.conf \
etc-cups/cups-pdf.conf \
etc-cups/snmp.conf \
etc-pam.d-cups \
start_cups.sh

include ../Makefile.inc

HIP=$(shell netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10)

RUNTERM=-it -a stdin -a stdout -a stderr --add-host=dockerhost:${HIP} -e HIP
OPTS=--skip-startup-files --no-kill-all-on-exit --quiet --skip-runit

CMD=bash -c 'config_cups.sh && sleep 3'
check: $(TS)
	docker run -e CUPS_USER_ADMIN=test0 -e CUPS_USER_PASSWORD=test0 -p 6631:631/tcp --rm ${RUNTERM} -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

