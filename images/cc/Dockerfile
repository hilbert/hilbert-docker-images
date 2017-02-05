FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.cc@gmail.com>

RUN update.sh && \
    install.sh build-essential make cmake g++ clang && \
    clean.sh

