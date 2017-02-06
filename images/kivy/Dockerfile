FROM hilbert/gui

MAINTAINER Oleksandr Motsak <malex984+hilbert.kivy@gmail.com>

# http://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer

RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A863D2D6 && \
    DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:kivy-team/kivy && \
    update.sh && install.sh python-kivy python-numpy && clean.sh
# TODO: python3?

RUN git clone https://github.com/stocyr/Deflectouch.git /usr/local/src/Deflectouch/
COPY run.sh /usr/local/src/Deflectouch/

## http://kivy.org/docs/api-kivy.input.providers.probesysfs.html#module-kivy.input.providers.probesysfs
## http://kivy.org/docs/api-kivy.input.providers.mtdev.html
## https://wiki.ubuntu.com/Multitouch
## https://launchpad.net/canonical-multitouch

# RUN update.sh && install.sh alsamixergui pulseaudio && clean.sh

# WORKDIR /usr/local/src/Deflectouch/




ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/kivy/Dockerfile"
LABEL org.label-schema.description="may be used as a base for all kivy-related images (gui + python-kivy)" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
