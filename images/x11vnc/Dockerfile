FROM hilbert/base

MAINTAINER Oleksandr Motsak <malex984+hilbert.x11vnc@gmail.com>

RUN update.sh && install.sh x11vnc && clean.sh

# VOLUME /tmp/.X11-unix/
COPY x11vnc.sh /usr/local/bin/

# ENV HOME /root
# RUN mkdir "$HOME/.vnc"
# Setup a password
# RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# x11vnc -usepw -forever

EXPOSE 5900-5910




ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/x11vnc/Dockerfile"
LABEL org.label-schema.description="x11vnc as a service" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
