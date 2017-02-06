mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
include ../Makefile.inc

#build: build_compose

CMD=hb_wrapper.sh launch.sh browser.sh -l file:///usr/local/src/mywebapp/test_heartbeatjs.html?HB_APP_ID=mywebapp&HB_URL=http://127.0.0.1:8888
# CMD=bash

check: $(TS)
	xhost +
	$(COMPOSE) -p $(COMPOSE_PROJECT_NAME) run --rm -e DISPLAY ${APP} ${CMD}

