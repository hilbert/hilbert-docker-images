mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc


PORTS= -p 9000:9000 -p 9999:9999 -p 7070:7070
RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=/sbin/my_init --skip-startup-files --skip-runit

# CMD=bash
RUN=/usr/local/run.sh
CMD=$(RUN)
ARGS=

check_compose: $(TS)
	export IMAGE_VERSION=${IMAGE_VERSION}
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm ${PORTS} ${APP} ${CMD} ${ARGS}
	unset IMAGE_VERSION

check_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -v "/tmp/:/tmp/:rw" ${PORTS} $(IMG) ${OPTS} -- ${CMD} ${ARGS}

check: check_compose

start: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) up -d --no-build ${APP}

restart: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) restart ${APP}

stop: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) stop -t 10 ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGTERM ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGKILL ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) rm -f ${APP}

