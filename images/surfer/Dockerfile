FROM hilbert/gui

MAINTAINER Oleksandr Motsak <malex984+hilbert.surfer@gmail.com>

#ADD https://imaginary.org/sites/default/files/surfer-1.2.4.x86_64.deb /tmp/surfer.deb
ADD https://imaginary.org/sites/default/files/surfer-1.5.0.x86_64.deb /tmp/surfer.deb

RUN update.sh \
 && dpkg -i /tmp/surfer.deb \
 && install.sh -fy \
 && clean.sh

RUN touch /root/.javafx_eula_accepted
COPY .fxsurfer /root/




ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/surfer/Dockerfile"
LABEL org.label-schema.description="Application: SURFER (1.5.0). Example for installing a .deb package" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
