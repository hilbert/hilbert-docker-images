ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.frozenlight@gmail.com>

ADD https://cloud.imaginary.org/index.php/s/fIR5p8KJx8Q0pMq/download /opt/frozenlight/frozenlight-1.2.2.jar

RUN apt-add-repository --yes ppa:webupd8team/java \
 && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && update.sh \
 && install.sh oracle-java8-installer=8u151-1~webupd8~0 oracle-java8-set-default \
 && install.sh -fy \
 && clean.sh

COPY frozenlight.sh /opt/

ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/surfer/Dockerfile"
LABEL org.label-schema.description="Application: Java JRE application: Frozen Light" \
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

