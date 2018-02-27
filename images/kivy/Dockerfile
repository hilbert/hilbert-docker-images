FROM hilbert/gui

LABEL maintainer "Volker Gaibler <volker.gaibler@h-its.org>"

# http://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update \
    && apt-get -qy install python-pip python3-pip build-essential git python python-dev \
            python3 python3-dev libav-tools libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev \
            libsdl2-ttf-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev \
            zlib1g-dev libgstreamer1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good

# setup virtual environments available to users
COPY setup-venv.sh /opt/kivy/
RUN pip2 install --upgrade pip virtualenv setuptools \
    && pip3 install --upgrade pip virtualenv setuptools \
    && cd /opt/kivy/ && ./setup-venv.sh

# default system-wide (if no virtual environments used)
RUN pip2 install Cython==0.23 \
    && pip2 install kivy==1.9.1 \
    && pip2 install numpy==1.13.3

# test application
RUN git clone https://github.com/stocyr/Deflectouch.git /usr/local/src/Deflectouch/
COPY run.sh /usr/local/src/Deflectouch/

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


CMD ["/bin/bash"]
