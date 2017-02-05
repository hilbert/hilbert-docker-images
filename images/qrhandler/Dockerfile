FROM hilbert/xeyes

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.qrhandler@gmail.com>

RUN update.sh && install.sh x11-utils xinput evemu-tools mtdev-tools scrot && clean.sh

COPY action.sh event qrhandler.sh /usr/local/bin/


