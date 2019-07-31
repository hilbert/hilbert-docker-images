mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))

# image tag
# it should correspond to hilbert/kiosk tag plus hitsfat extension
# e.g. "0.2.0-1" ("0.2.0" is hilbert/kiosk version, "-1" is hitsfat version number)
IMAGE_VERSION := devel_0.10.0-1

# site-specific settings
include ../../../Makefile-local.inc
#-include ~/interactives/0000_general/Secrets/storage-api.inc

U = hits
APP  = hitsfat

# default variables and targets
include ../Makefile.inc

# "build-tag-push-latest:
# set "latest" tag locally
# set "latest" tag on registry
IMGLATEST  ?= ${REPO}/${APP}:latest
TAGLATEST  ?= ${REGISTRY}/${U}/${APP}:latest

# ???????????????????????!!!!!!!!!!!!!!!!!!!! use build_hits instead!
build: build_hits
build_full: build_hits
