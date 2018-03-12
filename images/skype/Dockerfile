ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.skype@gmail.com>

# Setup multiarch because Skype is 32bit only
# Make sure the repository information is up to date

## adding custom build of apulse for 32 bit ubuntu:
COPY apulse/libpulsecommon-5.0.so apulse/libpulse-simple.so apulse/libpulse-simple.so.0 apulse/libpulse.so apulse/libpulse.so.0 /usr/lib/i386-linux-gnu/apulse/

# Install Skype (http://download.skype.com/linux/...)
ADD http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb /tmp/skype.deb

RUN dpkg --add-architecture i386 && \
    update.sh && \
    install.sh \
        alsa:i386 alsa-tools:i386 libglib2.0-dev:i386 libasound2-dev:i386 v4l-utils:i386 && \
    dpkg -i /tmp/skype.deb || true && \
    install.sh -fy && \
    clean.sh


### TODO: for later!
##COPY skype-4.3.0.37.tar.bz2 /usr/src/

# Our own starter via apulse: 
COPY skype.sh /usr/local/bin/




ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/skype/Dockerfile"
LABEL org.label-schema.description="skype - propitiatory 32-bit app. runs using apulse (emulation of pulseaudio via ALSA)." \
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

