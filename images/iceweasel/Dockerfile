ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.iceweasel@gmail.com>

# DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver ? --recv-keys ? && \
# ppa:mozillateam/firefox-stable ppa:mozillateam/firefox-next 

##RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-daily/ppa && \
##    update.sh && install.sh flashplugin-nonfree firefox-trunk && clean.sh
RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-security/ppa && \
    update.sh && install.sh flashplugin-nonfree firefox iceweasel && clean.sh

COPY firefox.sh browser.sh /usr/local/bin/



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/iceweasel/Dockerfile"
LABEL org.label-schema.description="Firefox & Iceweasel" \
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

