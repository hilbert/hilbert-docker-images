FROM hilbert/base

MAINTAINER Oleksandr Motsak <malex984+hilbert.qrhandler@gmail.com>

RUN update.sh && install.sh xauth x11-utils xinput evemu-tools mtdev-tools scrot xosd-bin && clean.sh
# libmtdev-dev libmtdev1 ?

COPY action.sh event qrhandler.sh /usr/local/bin/




ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/qrhandler/Dockerfile"
LABEL org.label-schema.description="prototype that can grab X11 input device (keyboard) and take screenshots" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
