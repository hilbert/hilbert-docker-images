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
XZ     ?= xz
GZIP   ?= gzip
BZIP2  ?= bzip2
GUNZIP ?= gunzip
BUNZIP2?= bunzip2
DOCKER ?= docker
COMPOSE?= docker-compose

#COMPOSE_PROJECT_NAME ?= dockapp
COMPOSE_PROJECT_NAME ?= hilbert

# https://stackoverflow.com/a/24472124
#PRE := $(shell rename : @COLON@ *)

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

# Get the latest git commit ID
GIT_COMMIT ?= $(strip $(shell git rev-parse --short HEAD))
# Get the git repository URL
GIT_ORIGIN_URL ?= $(strip $(shell git config --get remote.origin.url))
# Get the current checkout status
GIT_NOT_CLEAN_CHECK ?= $(strip $(shell git status --porcelain))

#ifneq (x$(GIT_NOT_CLEAN_CHECK), x)
#DOCKER_TAG_SUFFIX = "-dirty"
#endif

# CODE_VERSION = $(strip $(shell cat VERSION))

## See what commit is tagged to match the version
#VERSION_COMMIT = $(strip $(shell git rev-list $(CODE_VERSION) -n 1 | cut -c1-7))
#ifneq ($(VERSION_COMMIT), $(GIT_COMMIT))
#$(error echo You are trying to push a build based on commit $(GIT_COMMIT) but the tagged release version is $(VERSION_COMMIT))
#endif

VIDEO_DEVICES ?= `find /dev/ -group video -type c -exec echo -n "--device {} " \; 2>/dev/null`
AUDIO_DEVICES ?= `find /dev/ -group audio -type c -exec echo -n "--device {} " \; 2>/dev/null`


IMAGE_VERSION ?= latest
VCS_REF       ?= ${GIT_COMMIT}
VCS_URL       ?= ${GIT_ORIGIN_URL}


APP  ?= $(shell $(ECHO) "${current_dir}" | $(SED) -e 's@[\-]@_@g' | $(TR) '[:upper:]' '[:lower:]')
IMG  ?= ${REPO}/${APP}:${IMAGE_VERSION}
REGISTRY?=imaginary.mfo.de:5000
TAG  ?= ${REGISTRY}/${U}/${APP}:${IMAGE_VERSION}

IMG_TAR ?= ${REPO}.${APP}.${IMAGE_VERSION}.docker_image_tarball
IMG_GZ  ?= ${IMG_TAR}.gz
IMG_BZ2 ?= ${IMG_TAR}.bz2
IMG_XZ  ?= ${IMG_TAR}.xz

DF := ${mkfile_dir}/Dockerfile

### Parsing parts of Dockerfile:
BASE   :=$(shell $(GREP) -m 1 -iE '^ *FROM' "${DF}" | $(SED) -e 's@^ *FROM  *@@g' -e 's@[:/ ]@_@g')
BASETEG:=$(shell $(GREP) -m 1 -iE '^ *FROM' "${DF}" | $(SED) -e 's@^ *FROM  *@@g' -e 's@^.*/@@g')
COPYFILES2 :=$(shell $(GREP) -iE '^ *COPY ' "${DF}" | $(SED) -e 's@^ *COPY  *@@g' -e 's@ /.*@@g' | xargs -r)

# Absolute path to necessary local files
ACOPYFILES :=$(patsubst %,${mkfile_dir}/%,${COPYFILES})
ACOPYFILES2:=$(patsubst %,${mkfile_dir}/%,${COPYFILES2})

TS := ${top_dir}/${U}_${APP}_${IMAGE_VERSION}.timestamp
SS := ${top_dir}/${BASE}.timestamp

# POST = $(shell rename @COLON@ : *)

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
	$(ECHO)
	$(ECHO) "DOCKER_BUILD_OPTS : ${DOCKER_BUILD_OPTS}"

DOCKER_BUILD_OPTS_BASIC=--pull=false --force-rm=true --rm=true \
--no-cache=false

DOCKER_BUILD_OPTS_SIMPLE=${DOCKER_BUILD_OPTS_BASIC} \
--build-arg IMAGE_VERSION="${IMAGE_VERSION}"

DOCKER_BUILD_OPTS=${DOCKER_BUILD_OPTS_SIMPLE} \
--build-arg VCS_REF="${VCS_REF}" \
--build-arg VCS_URL="${VCS_URL}" \
--build-arg GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}" \
--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
--build-arg DOCKERFILE="/images/${APP}/${APP}_${IMAGE_VERSION}_Dockerfile"


TMP_DF=${mkfile_dir}/${APP}_${IMAGE_VERSION}_Dockerfile

build: 
	$(RM) -f "${TS}"
	$(CAT) "${DF}" | $(SED) -e 's@^FROM  *\([^ :#][^ :#]*\) *$$@FROM \1:$(IMAGE_VERSION)@g' > "${TMP_DF}"
	cd ${mkfile_dir} && $(DOCKER) -D build ${DOCKER_BUILD_OPTS_BASIC} -t "${IMG}" -f "${TMP_DF}" "${mkfile_dir}"
	$(DOCKER) images | $(GREP) -E "^${U}/${APP}  *" > "${TS}"
#	$(MAKE) -C ${mkfile_dir}/ "${TS}"

# "${ACOPYFILES}" "${ACOPYFILES2}"
# "${DF}"
build1: 
	$(RM) -f "${TS}"
	$(CAT) "${DF}" | $(SED) -e 's@^FROM  *\([^ :#][^ :#]*\) *$$@FROM \1:$(IMAGE_VERSION)@g' > "${TMP_DF}"
	cd ${mkfile_dir} && $(DOCKER) -D build ${DOCKER_BUILD_OPTS_SIMPLE} -t "${IMG}" -f "${TMP_DF}" "${mkfile_dir}"
	$(DOCKER) images | $(GREP) -E "^${U}/${APP}  *" > "${TS}"
#	$(MAKE) -C ${mkfile_dir}/ "${TS}"

# ${TS} ${SS} 
## Maybe try using docker-compose for building?
build_full:
	$(RM) -f "${TS}"
	$(CAT) "${DF}" | $(SED) -e 's@^FROM  *\([^ :#][^ :#]*\) *$$@FROM \1:$(IMAGE_VERSION)@g' > "${TMP_DF}"
	cd ${mkfile_dir} && $(DOCKER) -D build ${DOCKER_BUILD_OPTS} -t "${IMG}" -f "${TMP_DF}" "${mkfile_dir}"
	$(DOCKER) images | $(GREP) -E "^${U}/${APP}  *" > "${TS}"
#	$(MAKE) -C ${mkfile_dir}/ "${TS}"


"${SS}":
	cd ${top_dir}/${BASETEG}/ && $(MAKE) -C ${top_dir}/${BASETEG}/

"${top_dir}/hilbert_baseimage_${IMAGE_VERSION}.timestamp":
	$(DOCKER) pull 'hilbert/baseimage:${IMAGE_VERSION}'
	$(DOCKER) images | $(GREP) -E 'hilbert[\/]baseimage *[a-z]* ' > $@

${TS}:
	$(DOCKER) images | $(GREP) -E "^${U}/${APP}  *" > "$@"
	$(ECHO) "Created timestamp '${TS}' for image '${U}/${APP}'"

#	${TS}
# ${SS} 
# "${DF}" "${ACOPYFILES}" "${ACOPYFILES2}" "${mkfile_dir}/Makefile" "$(abspath $(lastword $(MAKEFILE_LIST)))"
rebuild: 
	$(RM) -f "${TS}"
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

test: ${TS} check

tag: ${TS}
	$(DOCKER) tag "${IMG}" "${TAG}"
	$(ECHO) "Created tag '${TAG}' for image '${IMG}'"

untag: ${TS}
	$(DOCKER) rmi "${TAG}"
	$(ECHO) "removed tag '${TAG}'"

push: ${TS}
	$(DOCKER) push "${TAG}"


# SAVE
savetar: ${TS}
	$(DOCKER) save "${IMG}" -o "${IMG_TAR}"

loadtar: ${IMG_TAR}
	$(DOCKER) load -i "${IMG_TAR}"
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

savegz: ${TS}
	$(DOCKER) save "${IMG}" | $(GZIP) -c -9 > "${IMG_GZ}"

loadgz: ${IMG_GZ}
	$(GUNZIP) -c "${IMG_GZ}" | $(DOCKER) load
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

savebz2: ${TS}
	$(DOCKER) save "${IMG}" | $(BZIP2) -z -c -9> "${IMG_BZ2}"

loadbz2: ${IMG_BZ2}
	$(BUNZIP2) -d -c "${IMG_BZ2}" | $(DOCKER) load
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

savexz: ${TS}
	$(DOCKER) save "${IMG}" | $(XZ) -z -9 -e -c - > "${IMG_XZ}"

loadxz: ${IMG_XZ}
	$(XZ) -d -c "${IMG_XZ}" | $(DOCKER) load
	$(MAKE) -C ${mkfile_dir}/ "${TS}"


# ${SS}
pull:
	$(DOCKER) pull "${IMG}"
	: $(DOCKER) tag "${IMG}" "${TAG}"
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

fix:
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

cleanup:
	(cd ${make_dir}; $(MAKE) -i -k -C ${make_dir} clean || true; cd - )
	$(DOCKER) rmi "${IMG}"
	$(RM) -f "${TS}"

prune:
	$(DOCKER) images -f "dangling=true" -q | xargs -r $(DOCKER) rmi

#force_look:
#	true


COMPOSE_BUILD_OPTS=--force-rm

# "${DF}" "${ACOPYFILES}" "${ACOPYFILES2}" 
build_compose: 
	$(RM) -f "${TS}"
	cd ${mkfile_dir} && $(COMPOSE) -p $(COMPOSE_PROJECT_NAME) build ${COMPOSE_BUILD_OPTS} ${APP}
	$(DOCKER) tag "${IMG}" "${TAG}"
	$(MAKE) -C ${mkfile_dir}/ "${TS}"

.SILENT :
