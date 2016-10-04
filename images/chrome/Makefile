mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

CMD=hb_wrapper.sh launch.sh browser.sh
GOOGLE_CHROME=google-chrome
# google-chrome
# chromium-browser
# opera

## ## --make-default-browser
## --enable-kiosk-mode --kiosk --disable-new-kiosk-ui
ARGS=
APP_ID=browser_app

# -it -a stdin -a stdout -a stderr 
# --privileged
RUNTERM=--ipc=host --net=host --pid=host -e GOOGLE_CHROME=$(GOOGLE_CHROME) 

# --no-kill-all-on-exit 
OPTS=--skip-startup-files --quiet --skip-runit

check: $(TS)
	### [ -z "${DISPLAY}" ] && exit 1
	xhost + || exit 1
	docker ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx
	docker run -d -e DISPLAY -e APP_ID="${APP_ID}" ${RUNTERM} --label is_top_app=1 -v /tmp/:/tmp/:rw -v /dev/shm:/dev/shm $(IMG) ${OPTS} -- ${CMD} ${ARGS} || true
	ls -al /dev/pts/ptmx
	: chmod a+rw /dev/pts/ptmx
