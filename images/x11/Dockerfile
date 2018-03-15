ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.x11@gmail.com>

RUN update.sh \
 && install.sh xserver-xorg xserver-xorg-video-all xserver-xephyr x11-xserver-utils xinit xvfb openbox \
 && clean.sh

# libgl1 libgles2 x11

# xorg-video-abi-18
# xserver-xorg-core \
# xorg-video-abi-19 
# unagi
#- compiz  
#- x11vnc 
#!  libx11 libxmu 
## libxi?


# VOLUME /tmp/.X11-unix/

# see testXephyr.sh
COPY Xorg.sh startXephyr.sh /usr/local/bin/

COPY .xinitrc /root/
#COPY .xinitrc /

RUN sed -i -e 's@^ *allowed_users=.*$@allowed_users=anybody@g' /etc/X11/Xwrapper.config

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz
# COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net=host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ 
#### -v /run/udev:/run/udev #x11?

# xcm?
# git://people.freedesktop.org/~ajax/xcm


ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/x11/Dockerfile"
LABEL org.label-schema.description="basis for Xorg/Xephyr service" \
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

