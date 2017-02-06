FROM hilbert/nodejs

MAINTAINER Oleksandr Motsak <malex984+hilbert.mng@gmail.com>

# download latest stable version and install node.js dependencies
RUN mkdir -p /usr/local/src \
 && git clone --depth 1 https://github.com/malex984/cors-image-proxy.git /usr/local/src/cors_proxy \
 && cd /usr/local/src/cors_proxy \
 && npm install

# main entry point
COPY run.sh /usr/local/

#EXPOSE 9000
#EXPOSE 9999

ARG IMAGE_VERSION=latest
ARG GIT_NOT_CLEAN_CHECK
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/cors_image_proxy/Dockerfile"
LABEL org.label-schema.description="Dumb CORS Proxy for images over http" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
