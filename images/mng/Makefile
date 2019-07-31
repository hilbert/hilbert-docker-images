mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=

IMAGE_VERSION?=devel_new
# nodejs10.16

include ../Makefile.inc

# IMAGE_VERSION ?= nodejs10.16

RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=/sbin/my_init --skip-startup-files --skip-runit

##TAG=titan.h-its.org:5555/${IMG}

# CMD=bash
RUN=/usr/local/run.sh
CMD=$(RUN)
ARGS=

check_compose: $(TS)
	export IMAGE_VERSION=${IMAGE_VERSION}
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm -p 8000:8000 ${APP} ${CMD} ${ARGS}
	unset IMAGE_VERSION

check_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -v "/tmp/:/tmp/:rw" -p 8000:8000 $(IMG) ${OPTS} -- ${CMD} ${ARGS}

check: check_compose

start: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) up -d --no-build ${APP}

stop: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) stop -t 10 ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGTERM ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGKILL ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) rm -f ${APP}

build: build_full

#COMPOSE_BUILD_OPTS=--force-rm

#build_compose: ${DF} ${ACOPYFILES} ${ACOPYFILES2}
#	$(RM) -f ${TS}
#	$(COMPOSE) -p $(COMPOSE_PROJECT_NAME) build ${COMPOSE_BUILD_OPTS} ${APP}
#	$(DOCKER) tag "${IMG}" "${TAG}"
#	$(MAKE) ${TS}

demo_compose: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm -p 8008:8008 demo

demo_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -p 8008:8008 $(IMG) ${OPTS} -- $(RUN) --test=1

demo: demo_compose
