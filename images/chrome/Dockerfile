ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}
#< Base image with the necessary libraries for web-browsers:

#! Person responsible for this image:
MAINTAINER Oleksandr Motsak <malex984+hilbert.chrome@gmail.com>

#! Default value for environment variable (used below)
ENV OPERA opera-stable

#! Get repository keys and add corresponding repository to package sources 
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

#! Another repository
RUN wget -q -O - http://deb.opera.com/archive.key | apt-key add - && \
    echo "deb http://deb.opera.com/${OPERA}/ stable non-free" >> /etc/apt/sources.list.d/opera.list

#! Update repository caches and install some SW packages. Do not forget to do clean-up
RUN update.sh && install.sh chromium-codecs-ffmpeg-extra google-chrome-stable chromium-browser ${OPERA} && clean.sh

#! Add necessary resources: wrapper scripts
COPY browser.sh chrome.sh /usr/local/bin/




ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/chrome/Dockerfile"
LABEL org.label-schema.description="Google Chrome & Chromium & Opera" \
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

