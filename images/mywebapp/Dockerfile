FROM hilbert/kiosk
ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>
RUN mkdir -p /usr/local/src/mywebapp
COPY test_heartbeatjs.html hb.js /usr/local/src/mywebapp/
