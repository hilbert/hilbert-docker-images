ARG IMAGE_VERSION=someversion
FROM hilbert/nodejs:${IMAGE_VERSION}

# NOTE: taken from https://github.com/vga101/meshcommander and modified to fit Hilbert image hierarchy
MAINTAINER Oleksandr Motsak <malex984+hilbert.meshcommander@gmail.com>

RUN update.sh && install.sh unzip

RUN mkdir /usr/local/src/meshcommander \
&& cd /usr/local/src/meshcommander \
&& wget -q "http://info.meshcentral.com/downloads/mdtk/meshcommandersource.zip" && unzip meshcommandersource.zip && rm meshcommandersource.zip \
&& cd MeshCommander/NodeJS \
&& npm install

EXPOSE 3000

RUN echo -e '#!/bin/sh\ncd /usr/local/src/meshcommander/MeshCommander/NodeJS/ && exec node commander.js $@\n' > /usr/local/bin/runmeshcmdr.sh \
&& chmod +x /usr/local/bin/runmeshcmdr.sh

#WORKDIR /usr/local/src/meshcommander/MeshCommander/NodeJS/
#CMD ["/usr/local/bin/runmeshcmdr.sh"]


ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/meshcommander/Dockerfile"
LABEL org.label-schema.description="Manageability Commander: interact with Intel AMT within a browser" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0"     

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
