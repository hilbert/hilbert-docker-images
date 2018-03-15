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

RUNTERM=-it -a stdin -a stdout -a stderr -e HIP -e CUPS_SERVER

OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

# todo: download test pdf , lpr, lpq, lprm-job , lpq
CMD=bash -c 'config_cups.sh && lpq && sleep 3'

check: $(TS)
	docker run -rm ${RUNTERM} --label is_top_app=0 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

# -e CUPS_USER_ADMIN=test0 -e CUPS_USER_PASSWORD=test0 -p 6631:631/tcp # unused together with the cups server itself

build: build_full
