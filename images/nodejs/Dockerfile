ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.nodejs@gmail.com>

# https://github.com/nodesource/distributions

#RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
#ADD https://deb.nodesource.com/setup_4.x /tmp/setup_4.sh
#RUN chmod +x /tmp/setup_4.sh && bash /tmp/setup_4.sh

## curl --silent --location https://deb.nodesource.com/setup_4.x | sudo -E bash -
## wget -qO- https://deb.nodesource.com/setup_4.x | bash -

RUN update.sh \
 && DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
 && install.sh nodejs \
 && clean.sh

#RUN npm install electron-prebuilt -g 
## && npm install asar -g && \
##    npm install yargs -g

# ONBUILD COPY package.json index.html main.js /usr/src/kiosk/
# CMD [ "npm", "start" ]
# CMD [ "launch.sh", "/usr/src/kiosk/run.sh" ] ## nodejs



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/nodejs/Dockerfile"
LABEL org.label-schema.description="contains basic Node JS 4" \
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
