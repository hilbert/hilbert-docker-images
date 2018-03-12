ARG IMAGE_VERSION=someversion
FROM hilbert/baseimage:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.ptmx@gmail.com>

COPY ptmx.sh /usr/local/bin/


# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"
# ARG VERSION=${IMAGE_VERSION}
ARG GIT_NOT_CLEAN_CHECK
ARG DOCKERFILE="/images/ptmx/Dockerfile"

LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.description="service to try to workarouind the problem of permissions to /dev/pts/ptmx" \
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
