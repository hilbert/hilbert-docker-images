# http://stackoverflow.com/questions/18136918/how-to-get-current-directory-of-your-makefile
# http://www.gnu.org/software/make/manual/make.html#toc-Quick-Reference-1

CAT    ?= cat
RM     ?= rm
ECHO   ?= echo
SHELL  ?= /bin/bash
GREP   ?= grep
SED    ?= sed
MAKE   ?= make
TR     ?= tr
DOCKER ?= docker
COMPOSE?= docker-compose

#COMPOSE_PROJECT_NAME ?= dockapp
COMPOSE_PROJECT_NAME ?= hilbert

# Makefile.inc is expected to be on the top level!
top_dir       :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
#top_dir_name :=$(notdir $(patsubst %/,%,$(mkp))) # $(CURDIR)
mkfile_dir    := $(dir $(mkfile_path))
current_dir   := $(notdir $(patsubst %/,%,$(mkfile_dir)))


#### Docker Hub-related refs:
U    ?= hilbert
REPO ?= ${U}
# /${I}
# TODO: Add tag depending on git branch!?
IMAGE_VERSION ?= latest

APP  ?= $(shell $(ECHO) "${current_dir}" | $(SED) -e 's@[\-]@_@g' | $(TR) '[:upper:]' '[:lower:]')
IMG  ?= ${REPO}/${APP}:${IMAGE_VERSION}
TAG  ?= imaginary.mfo.de:5000/${U}/${APP}:${IMAGE_VERSION}

DF     :=${mkfile_dir}/Dockerfile

### Parsing parts of Dockerfile:
BASE   :=$(shell $(GREP) -m 1 -iE '^ *FROM' ${DF} | $(SED) -e 's@^ *FROM  *@@g' -e 's@[:/ ]@_@g')
BASETEG:=$(shell $(GREP) -m 1 -iE '^ *FROM' ${DF} | $(SED) -e 's@^ *FROM  *@@g' -e 's@^.*/@@g')
COPYFILES2 :=$(shell $(GREP) -iE '^ *COPY ' ${DF} | $(SED) -e 's@^ *COPY  *@@g' -e 's@ /.*@@g' | xargs -r)

# Absolute path to necessary local files
ACOPYFILES :=$(patsubst %,${mkfile_dir}/%,${COPYFILES})
ACOPYFILES2:=$(patsubst %,${mkfile_dir}/%,${COPYFILES2})

TS := ${top_dir}/${U}_${APP}_${IMAGE_VERSION}.timestamp
SS := ${top_dir}/${BASE}.timestamp


all: show debug build prune show

show:
	$(ECHO)
	$(DOCKER) images
	$(DOCKER) ps -a
	ls -al /dev/pts/ptmx 
	: chmod a+rw /dev/pts/ptmx

debug:
	$(ECHO)
	$(ECHO) "Top dir           : ${top_dir}"
	$(ECHO) "Dockerfile        : ${DF}"
	$(ECHO) "Target            : ${TS}"
	$(ECHO)
	$(ECHO) "Base              : ${BASETEG} -> ${BASE}"
	$(ECHO) "Req               : ${SS}"
	$(ECHO)
	$(ECHO) "Deps              : ${ACOPYFILES}"
	$(ECHO) "Auto Deps         : ${ACOPYFILES2}"


DOCKER_BUILD_OPTS=--pull=false --force-rm=true --rm=true --build-arg IMAGE_VERSION=${IMAGE_VERSION}
# --no-cache=true

TMP_DF=${mkfile_dir}/Dockerfile_${APP}_${IMAGE_VERSION}

# ${TS} ${SS} 
## Maybe try using docker-compose for building?
build: ${DF} ${ACOPYFILES} ${ACOPYFILES2}
	$(RM) -f ${TS}  ### 
	$(CAT) "${DF}" | $(SED) -e "s@FROM  *${U}/${APP}@FROM ${U}/${APP}:${IMAGE_VERSION}@g" > "${TMP_DF}"
	cd ${mkfile_dir} && $(DOCKER) -D build ${DOCKER_BUILD_OPTS} -t "${IMG}" -f "${TMP_DF}" "${mkfile_dir}"
	$(DOCKER) tag "${IMG}" "${TAG}"
	$(MAKE) -C ${mkfile_dir}/ ${TS}

${SS}:
	cd ${top_dir}/${BASETEG}/ && $(MAKE) -C ${top_dir}/${BASETEG}/

${top_dir}/phusion_baseimage_0.9.18.timestamp:
	$(DOCKER) pull 'phusion/baseimage:0.9.18'
	$(DOCKER) images | $(GREP) -E 'phusion[\/]baseimage *0[\.]9[\.]18 ' > $@

#${top_dir}/docker_compose_1.6.2.timestamp:
#	$(DOCKER) pull 'docker/compose:1.6.2'
#	$(DOCKER) images | grep -E 'docker[\/]compose *1[\.]6[\.]2 ' > $@

${TS}:
	$(DOCKER) images | $(GREP) -E "^${U}/${APP}  *" > $@
#	${TS}
# ${SS} 
rebuild: ${DF} ${ACOPYFILES} ${ACOPYFILES2} ${mkfile_dir}/Makefile $(abspath $(lastword $(MAKEFILE_LIST)))
	$(RM) -f ${TS}
	$(MAKE) -C ${mkfile_dir}/ ${TS}

test: $(TS) check

push: ${TS}
	$(DOCKER) push "${TAG}"

# ${SS}
pull:
	$(DOCKER) pull "${IMG}"
	$(DOCKER) tag "${IMG}" "${TAG}"
	$(MAKE) -C ${mkfile_dir}/ ${TS}
	
fix:
	$(MAKE) -C ${mkfile_dir}/ ${TS}


cleanup:
	(cd ${make_dir}; $(MAKE) -i -k -C ${make_dir} clean || true; cd - )
	$(DOCKER) rmi "${IMG}"
	$(RM) -f ${TS}

prune:
	$(DOCKER) images -f "dangling=true" -q | xargs -r $(DOCKER) rmi
	
#force_look:
#	true


COMPOSE_BUILD_OPTS=--force-rm

build_compose:${DF} ${ACOPYFILES} ${ACOPYFILES2} 
	$(RM) -f ${TS}
	cd ${mkfile_dir} && $(COMPOSE) -p $(COMPOSE_PROJECT_NAME) build ${COMPOSE_BUILD_OPTS} ${APP}
	$(DOCKER) tag "${IMG}" "${TAG}"
	$(MAKE) -C ${mkfile_dir}/ ${TS}

.SILENT :
