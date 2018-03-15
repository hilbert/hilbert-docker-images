ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}
###FROM hilbert/nodejs::::

MAINTAINER Oleksandr Motsak <malex984+hilbert.mng@gmail.com>

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


# install dependencies
RUN update.sh && \
    install.sh nginx rsync wakeonlan openssh-client && \
    clean.sh && \
    rm -fR /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default /root/.ssh

#    python3-pip lftp 
#    pip3 install --upgrade pip && pip install --upgrade setuptools && \
#    pip install dill semantic_version ruamel.yaml argcomplete && \

# tell Docker which port is exposed by the container
# EXPOSE 8000

# RUN mkdir -p /usr/local/src

# download latest stable version and install node.js dependencies
RUN git clone --depth 1 -b 'master' https://github.com/hilbert/hilbert-ui.git /usr/local/hilbert-ui \
    && cd /usr/local/hilbert-ui/client && npm install && cd /usr/local/hilbert-ui/server && npm install

# download latest version. (note: required python packages were installed above)
#RUN git clone --depth 1 -b 'devel' https://github.com/hilbert/hilbert-cli.git /tmp/hilbert_cli \
#    && cd /tmp/hilbert_cli && python3 ./setup.py install

ENV HILBERT_CLI_PATH=/usr/local/bin

ADD "https://cloud.imaginary.org/index.php/s/WSGU4yEaR4RaH3T/download?path=%2F&files=hilbert" /usr/local/bin/hilbert
RUN chmod a+x /usr/local/bin/hilbert

# Dummy script checker  (instead of full Haskel Suite)
COPY shellcheck /usr/local/bin/

# configure services for baseimage-docker's init system
#RUN echo "#!/bin/sh\nnginx" > /etc/rc.local

#RUN mkdir -p /etc/service/hilbert_ui_api \
#    && echo "#!/bin/sh\ncd /usr/local/hilbert-ui/server/app\nexec node main.js" > /etc/service/hilbert_ui_api/run \
#    && chmod +x  /etc/service/hilbert_ui_api/run

# main entry point
COPY nginx.sh run.sh /usr/local/

ENV HOME /root



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/mng/Dockerfile"
LABEL org.label-schema.description="Hilbert Dashboard UI (including Hilbert server tool)" \
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
