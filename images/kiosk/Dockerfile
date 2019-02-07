ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.kiosk@gmail.com>

# https://github.com/nodesource/distributions

#RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

#ADD https://deb.nodesource.com/setup_6.x  /tmp/setup_6.sh
#RUN chmod +x /tmp/setup_6.sh && bash /tmp/setup_6.sh

##  curl --silent --location https://deb.nodesource.com/setup_4.x | sudo -E bash -
### wget -qO- https://deb.nodesource.com/setup_4.x | bash -


# Legacy Kiosk Browser: 0.9.0 # https://cloud.imaginary.org/index.php/s/gwqWQbWu4xTsoQ8

RUN update.sh \
 && install.sh gconf2 gconf-service libnotify4 libappindicator1 libxtst6 libnss3 libxss1 \
 && wget -q "https://cloud.imaginary.org/index.php/s/XYH8k1wxxz25d2J/download?path=%2F&files=kiosk-browser_0.10.0_amd64.deb" -O /tmp/kiosk-browser.deb \
 && dpkg -i /tmp/kiosk-browser.deb \
 && install.sh -fy \
 && clean.sh # && mv /opt/kiosk-browser /opt/kiosk-browser.0.9.0

#RUN npm install electron-prebuilt -g 
## && npm install asar -g && \
##    npm install yargs -g

#RUN mkdir -p /usr/local/src/kiosk
# WORKDIR /usr/local/src/kiosk/

#COPY package.json /usr/local/src/kiosk/
#RUN cd /usr/local/src/kiosk && npm install electron-prebuilt --save-dev && npm install yargs --save-dev

ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/v1.0.0/client/js/hilbert-heartbeat.js /usr/local/share/hilbert-heartbeat.js
ENV HB_LIBRARY_FILE /usr/local/share/hilbert-heartbeat.js

COPY browser.sh run.sh kiosk.sh testapp.sh hb_preload.sh /usr/local/bin/
# TODO: add those scripts from Kiosk repository (when it will be public)!?

# ONBUILD COPY package.json index.html main.js /usr/src/kiosk/
# CMD [ "npm", "start" ]
# CMD [ "launch.sh", "/usr/src/kiosk/run.sh" ] ## kiosk
# /usr/local/src/kiosk/run.sh # !




ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/kiosk/Dockerfile"
LABEL org.label-schema.description="Kiosk-mode browser using Electron. Base for WebBrowser-related images (as well as hilbert/gui). See https://github.com/IMAGINARY/kiosk-browser" \
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

