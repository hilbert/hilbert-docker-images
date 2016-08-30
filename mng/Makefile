mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   :=
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr 
# -p 8077:8066
OPTS=--skip-startup-files --skip-runit

# CMD=bash
CMD=/DOCKAPP/run.sh

# COMPOSE_PROJECT_NAME=dockapp

## COPY dockapp_dashboard /usr/local/dockapp_dashboard
check_compose: $(TS)
	docker-compose -p $(COMPOSE_PROJECT_NAME) run --rm --service-ports ${APP} ${CMD} # ${OPTS} -- ?

check_docker: $(TS)
	docker run --rm ${RUNTERM} --label is_top_app=1 -v "/tmp/:/tmp/:rw" -v "${PWD}:/DOCKAPP:rw" -v "${HOME}/.ssh:/root/.ssh:ro"  -v "${HOME}:${HOME}:ro" -v "${PWD}/dockapp_dashboard:/usr/local/dockapp_dashboard:ro" -p 8081:8080 $(IMG) ${OPTS} -- ${CMD}

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
