mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=/sbin/my_init --skip-startup-files --skip-runit

##TAG=titan.h-its.org:5555/${IMG}

# CMD=bash
RUN=/usr/local/bin/runmeshcmdr.sh
CMD=$(RUN)
ARGS=

check_compose: $(TS)
	export IMAGE_VERSION=${IMAGE_VERSION}
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm -p 3000:3000 ${APP} ${CMD} ${ARGS}
	unset IMAGE_VERSION

check_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=0 -v "/tmp/:/tmp/:rw" -p 3000:3000 $(IMG) ${OPTS} -- ${CMD} ${ARGS}

check: check_docker
# check_compose

start: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) up -d --no-build ${APP}

stop: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) stop -t 10 ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGTERM ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGKILL ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) rm -f ${APP}

build: build_full
