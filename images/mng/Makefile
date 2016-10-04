mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=--skip-startup-files --skip-runit

# CMD=bash
RUN=/usr/local/run.sh
CMD=$(RUN)
ARGS=

# COMPOSE_PROJECT_NAME=dockapp

## COPY dockapp_dashboard /usr/local/dockapp_dashboard
check_compose: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm -p 8081:8080 ${APP} ${CMD} ${ARGS}

check_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -v "/tmp/:/tmp/:rw" -p 8081:8080 $(IMG) ${OPTS} -- ${CMD} ${ARGS}

check: check_compose

start: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) up -d --no-build ${APP}

stop: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) stop -t 10 ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGTERM ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) kill -s SIGKILL ${APP}
	docker-compose -p $(COMPOSE_PROJECT_NAME) rm -f ${APP}
		

#COMPOSE_BUILD_OPTS=--force-rm
#build: ${DF} ${ACOPYFILES} ${ACOPYFILES2}
#	$(RM) -f ${TS}
#	$(COMPOSE) -p $(COMPOSE_PROJECT_NAME) build ${COMPOSE_BUILD_OPTS} ${APP}
#	$(DOCKER) tag "${IMG}" "${TAG}"
#	$(MAKE) ${TS}

demo_compose: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm -p 8088:8080 demo

demo_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -p 8088:8080 $(IMG) ${OPTS} -- $(RUN) --test=true

demo: demo_compose
