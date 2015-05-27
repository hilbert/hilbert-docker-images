RM=rm
ECHO=echo
SHELL=/bin/bash
GREP=grep
SED=sed
MAKE=make
DOCKER=docker

U := malex984
I := dockapp
REPO:=${U}/${I}

# http://stackoverflow.com/questions/18136918/how-to-get-current-directory-of-your-makefile
# http://www.gnu.org/software/make/manual/make.html#toc-Quick-Reference-1

# Makefile.inc is expected to be on the top level!
top_dir:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
#top_dir_name:=$(notdir $(patsubst %/,%,$(mkp))) # $(CURDIR)

mkfile_dir  := $(dir $(mkfile_path))
current_dir := $(notdir $(patsubst %/,%,$(mkfile_dir)))

APP:=${current_dir}
IMG:=${REPO}:${APP}

DF:=${mkfile_dir}/Dockerfile
BASE:=$(shell $(GREP) -m 1 -iE '^ *FROM' ${DF} | $(SED) -e 's@^ *FROM  *@@g' -e 's@[:/ ]@_@g')
BASETEG:=$(shell $(GREP) -m 1 -iE '^ *FROM' ${DF} | $(SED) -e 's@^ *FROM *@@g' -e 's@${REPO}:@@g' -e 's@[:/ ]@_@g')


ACOPYFILES:=$(patsubst %,${mkfile_dir}/%,${COPYFILES})

COPYFILES2:=$(shell $(GREP) -iE '^ *COPY ' ${DF} | $(SED) -e 's@^ *COPY  *@@g' -e 's@ /.*@@g' | xargs)
ACOPYFILES2:=$(patsubst %,${mkfile_dir}/%,${COPYFILES2})

TS:=${top_dir}/${U}_${I}_${APP}.timestamp
SS:=${top_dir}/${BASE}.timestamp

all: debug build

debug:
	echo "Current Dockerfile: ${DF}"
	echo "Base: ${BASETEG} -> ${BASE}, Req: ${SS}"
	echo "Target: ${TS}"
	echo "Top dir: ${top_dir}"
	echo "Deps: ${ACOPYFILES}, ${ACOPYFILES2}"

build: ${TS}

${SS}:
	cd ${top_dir}/${BASETEG}/ && $(MAKE) -C ${top_dir}/${BASETEG}/

${top_dir}/phusion_baseimage_0.9.16.timestamp:
	$(DOCKER) pull 'phusion/baseimage:0.9.16'
	$(DOCKER) images | grep -E 'phusion[\/]baseimage *0[\.]9[\.]16 ' > $@


DOCKER_BUILD_OPTS=--pull=false --force-rm=true --rm=true
# --no-cache=true

${TS}: ${DF} ${SS} ${ACOPYFILES} ${ACOPYFILES2}
	cd ${mkfile_dir} && docker build ${DOCKER_BUILD_OPTS} -t ${IMG} ${mkfile_dir}
	docker images | $(GREP) "${U}/${I} " | $(GREP) ${APP} > $@

rebuild: ${DF} ${SS} ${ACOPYFILES} ${ACOPYFILES2} ${mkfile_dir}/Makefile $(abspath $(lastword $(MAKEFILE_LIST))) 
	$(RM) -f ${TS}
	$(MAKE) -C ${mkfile_dir}/ ${TS}


test: $(TS) check

push: ${TS}
	docker push "${IMG}"

# ${SS}
pull:
	docker pull "${IMG}"
	docker images | grep "${U}/${I} " | grep ${APP} > ${TS}


#force_look:
#	true


.SILENT :
