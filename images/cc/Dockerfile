FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && \
    install.sh build-essential make cmake g++ clang && \
    clean.sh

