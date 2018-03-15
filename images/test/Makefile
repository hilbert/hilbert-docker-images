mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := GpuTest_Linux_x64_0.7.0.tar.bz2 bm_gpu.sh ilkh.sh test_nv.sh test_sys.sh test_vbox.sh test_x11.sh
include ../Makefile.inc

CMD=launch.sh xterm -e bash /usr/src/bm_gpu.sh

RUNTERM=-it -a stdin -a stdout -a stderr --ipc=host --net=host
OPTS=/sbin/my_init --skip-startup-files --quiet --skip-runit

### [ -z "${DISPLAY}" ] && exit 1
check: $(TS)
	xhost + || exit 1
	docker ps -a
	docker run --rm -e DISPLAY ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw $(IMG) ${OPTS} -- ${CMD}

build: build_full
