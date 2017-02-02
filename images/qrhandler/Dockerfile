FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.qrhandler@gmail.com>

RUN update.sh && install.sh xauth x11-utils xinput evemu-tools mtdev-tools scrot xosd-bin && clean.sh
# libmtdev-dev libmtdev1 ?

COPY action.sh event qrhandler.sh /usr/local/bin/


