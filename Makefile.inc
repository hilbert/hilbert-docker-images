RM=rm
ECHO=echo
SHELL=/bin/bash
GREP=grep
SED=sed

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

TS:=${top_dir}/${U}_${I}_${APP}.timestamp
SS:=${top_dir}/${BASE}.timestamp

all: debug build

debug:
	echo "Current Dockerfile: ${DF}"
	echo "Base: ${BASETEG} -> ${BASE}, Req: ${SS}"
	echo "Target: ${TS}"
	echo "Additions: ${ACOPYFILES}"
	echo "Top data: ${mkp}, ${top_dir}"

#	echo "$(MAKEFILE_LIST)"

build: ${TS}

${SS}:
	cd ${top_dir}/${BASETEG}/ && make -C ${top_dir}/${BASETEG}/

${top_dir}/phusion_baseimage_0.9.16.timestamp:
	docker pull 'phusion/baseimage:0.9.16'
	docker images | grep -E 'phusion[\/]baseimage *0[\.]9[\.]16 ' > $@


DOCKER_BUILD_OPTS=--pull=false --force-rm=true --rm=true
# --no-cache=true


${TS}: ${DF} ${SS} ${ACOPYFILES} $(abspath $(lastword $(MAKEFILE_LIST))) ${mkfile_dir}/Makefile
	cd ${mkfile_dir} && docker build ${DOCKER_BUILD_OPTS} -t ${IMG} ${mkfile_dir}
	docker images | grep "${U}/${I} " | grep ${APP} > $@



push: ${TS}
	docker push "${IMG}"


#force_look:
#	true


.SILENT :
