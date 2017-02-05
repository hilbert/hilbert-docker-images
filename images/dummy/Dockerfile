FROM hilbert/x11

MAINTAINER Oleksandr Motsak <malex984+hilbert.dummy@gmail.com>

# RUN update.sh && install.sh p7zip-full pciutils && clean.sh

COPY test_nv.sh test_vbox.sh setup_nv.sh setup_vb.sh setup_alsa.sh customize.sh ilkh.sh /usr/local/bin/

# VOLUME /




ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/dummy/Dockerfile"
LABEL org.label-schema.description="used for running X11 and HW customization for GPU (OpenGL-library)" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
