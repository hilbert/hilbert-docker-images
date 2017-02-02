FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.q3@gmail.com>

RUN update.sh && install.sh openarena && clean.sh

COPY q3.sh bench.sh /usr/local/bin/


