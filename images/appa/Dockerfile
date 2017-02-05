FROM hilbert/base

MAINTAINER Oleksandr Motsak <malex984+hilbert.appa@gmail.com>

# Clean up APT when done.
# RUN clean.sh

COPY A.sh /usr/local/bin/

# ENV HOME /home/ur
# RUN chown ur:ur $HOME/bin/A.sh
# CMD /sbin/setuser ur /home/ur/bin/A.sh


ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/appa/Dockerfile"
LABEL org.label-schema.description="image run simple shell scripts saying AAA... or BBB... and sending Heartbeat" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
