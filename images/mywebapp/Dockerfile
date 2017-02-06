FROM hilbert/kiosk

MAINTAINER Oleksandr Motsak <malex984+hilbert.mywebapp@gmail.com>
RUN mkdir -p /usr/local/src/mywebapp
COPY test_heartbeatjs.html hb.js /usr/local/src/mywebapp/



ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/mywebapp/Dockerfile"
LABEL org.label-schema.description="Demo application: WebBrowser (Kiosk-mode Browser using Electron) + Web content" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
