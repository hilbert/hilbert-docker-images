ARG IMAGE_VERSION=someversion
FROM hilbert/nodejs:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.cors.proxy@gmail.com>

# download latest stable version and install node.js dependencies
RUN mkdir -p /usr/local/src \
 && git clone --depth 1 https://github.com/malex984/cors-image-proxy.git /usr/local/src/cors_proxy \
 && cd /usr/local/src/cors_proxy \
 && npm install

# main entry point
COPY run.sh /usr/local/

#EXPOSE 9000
#EXPOSE 9999

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

