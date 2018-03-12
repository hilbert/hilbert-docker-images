ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.surfer@gmail.com>

#ADD https://imaginary.org/sites/default/files/surfer-1.2.4.x86_64.deb /tmp/surfer.deb
#ADD https://imaginary.org/sites/default/files/surfer-1.7.0.x86_64.deb /tmp/surfer.deb

RUN update.sh \
 && install.sh fonts-wqy-microhei libxslt1.1 \
 && wget -q "https://cloud.imaginary.org/index.php/s/9ZLTBdiVtY7pbMb/download" -O /tmp/surfer.deb \
 && mkdir -p /usr/share/desktop-directories/ \
 && dpkg -i /tmp/surfer.deb \
 && install.sh -fy \
 && clean.sh

#RUN touch /root/.javafx_eula_accepted
#COPY .fxsurfer /root/


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

