ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.alsa@gmail.com>

# Update & Install & Clean up APT
# Not: please if possible add all the packages to the following single install command!
RUN update.sh && install.sh alsa alsa-tools alsa-utils && clean.sh

# RUN usermod -a -G pulse-access ur
# RUN usermod -a -G pulse ur
# RUN usermod -a -G audio ur

#### TODO: $HOME?
# COPY .asoundrc /root/
# RUN chown ur:ur /home/ur/.asoundrc.save
 
# pulseaudio?
# ADD 01_pulseaudio /etc/my_init.d/01_pulseaudio

COPY soundtest.sh /usr/local/bin/
ADD http://www.alsa-project.org/alsa-info.sh /usr/local/bin/alsa-info.sh
RUN chmod +x /usr/local/bin/alsa-info.sh

# build-essential cmake libglib2.0-dev libasound2-dev ?
# RUN git clone https://github.com/i-rinat/apulse.git /usr/src/apulse/
# RUN mkdir -p /tmp/build && cd /tmp/build && \
#    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release /usr/src/apulse/ && \
#    make && make install

#  cmus paprefs ?


ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/alsa/Dockerfile"
LABEL org.label-schema.description="scripts for testing audio HW using ALSA" \
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

