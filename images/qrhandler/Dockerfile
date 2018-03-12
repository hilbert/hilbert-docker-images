ARG IMAGE_VERSION=someversion
FROM hilbert/dd:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.qrhandler@gmail.com>

RUN update.sh && install.sh xauth x11-utils xinput evemu-tools mtdev-tools scrot xosd-bin && clean.sh
# libmtdev-dev libmtdev1 ?

COPY action.sh event qrhandler.sh get_top.sh /usr/local/bin/


ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/qrhandler/Dockerfile"
LABEL LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.description="prototype that can grab X11 input device (keyboard)" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"

ONBUILD LABEL org.label-schema.build-date="" \
      org.label-schema.name="" \
      org.label-schema.description="" \
      org.label-schema.vendor="" \
      org.label-schema.url="" \
      org.label-schema.vcs-ref="" \
      org.label-schema.vcs-url="" \
      org.label-schema.version="" \
      org.label-schema.schema-version="" \
      com.microscaling.license="" \
      com.microscaling.docker.dockerfile="" \
      IMAGE_VERSION="" \
      GIT_NOT_CLEAN_CHECK=""
