FROM hilbert/gui

MAINTAINER Oleksandr Motsak <malex984+hilbert.iceweasel@gmail.com>

# DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver ? --recv-keys ? && \
# ppa:mozillateam/firefox-stable ppa:mozillateam/firefox-next 

##RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-daily/ppa && \
##    update.sh && install.sh flashplugin-nonfree firefox-trunk && clean.sh
RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-security/ppa && \
    update.sh && install.sh flashplugin-nonfree firefox iceweasel && clean.sh

COPY firefox.sh browser.sh /usr/local/bin/



ARG IMAGE_VERSION=latest
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
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
