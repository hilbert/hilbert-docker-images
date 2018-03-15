ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.kivy@gmail.com>

# http://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer

#    DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:kivy-team/kivy && \
RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A863D2D6 \
 && DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:kivy-team/kivy-daily \
 && update.sh \
 && install.sh python-kivy python-numpy \
 && clean.sh

# TODO: python3?

#RUN https://github.com/kivy/kivy/archive/1.10.0.tar.gz
# git clone http://github.com/kivy/kivy
# cd kivy
#sudo apt-get install cython libgstreamer1.0-dev libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev
# make # make mesabuild # sudo make install
#sudo apt-get install checkinstall
#sudo checkinstall python setup.py install


RUN git clone https://github.com/stocyr/Deflectouch.git /usr/local/src/Deflectouch/
COPY run.sh /usr/local/src/Deflectouch/

## http://kivy.org/docs/api-kivy.input.providers.probesysfs.html#module-kivy.input.providers.probesysfs
## http://kivy.org/docs/api-kivy.input.providers.mtdev.html
## https://wiki.ubuntu.com/Multitouch
## https://launchpad.net/canonical-multitouch

# RUN update.sh && install.sh alsamixergui pulseaudio && clean.sh

# WORKDIR /usr/local/src/Deflectouch/




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

