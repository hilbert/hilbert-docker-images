FROM hilbert/nodejs

MAINTAINER Oleksandr Motsak <malex984+hilbert.mng@gmail.com>

# install dependencies
RUN update.sh && \
    install.sh nginx rsync lftp wakeonlan python3-pip openssh-client && \
    pip3 install --upgrade pip && pip install --upgrade setuptools && \
    pip install dill semantic_version ruamel.yaml argcomplete && \
    clean.sh && \
    rm -fR /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default /root/.ssh

# tell Docker which port is exposed by the container
# EXPOSE 8000

RUN mkdir -p /usr/local/src

# download latest stable version and install node.js dependencies
RUN git clone --depth 1 -b 'master' https://github.com/hilbert/hilbert-ui.git /usr/local/hilbert-ui \
    && cd /usr/local/hilbert-ui/client && npm install && cd /usr/local/hilbert-ui/server && npm install

# download latest version. (note: required python packages were installed above)
RUN git clone --depth 1 -b 'devel' https://github.com/hilbert/hilbert-cli.git /usr/local/src/cli \
    && cd /usr/local/src/cli && python3 ./setup.py install 

# Dummy script checker  (instead of full Haskel Suite)
COPY shellcheck /usr/local/bin/
COPY config.json /usr/local/hilbert-ui/server/

#COPY scripts /usr/local/hilbert-ui/server/scripts/

RUN mkdir -p /usr/local/hilbert-ui/server/scripts/

ADD https://raw.githubusercontent.com/hilbert/hilbert-cli/aff706eeea031f928ed1b9a00189a03d01bf271b/server/appchange_station.sh /usr/local/hilbert-ui/server/scripts/appchange_station.sh
ADD https://raw.githubusercontent.com/hilbert/hilbert-cli/aff706eeea031f928ed1b9a00189a03d01bf271b/server/list_applications.sh /usr/local/hilbert-ui/server/scripts/list_applications.sh
ADD https://raw.githubusercontent.com/hilbert/hilbert-cli/aff706eeea031f928ed1b9a00189a03d01bf271b/server/list_profiles.sh /usr/local/hilbert-ui/server/scripts/list_profiles.sh
ADD https://raw.githubusercontent.com/hilbert/hilbert-cli/aff706eeea031f928ed1b9a00189a03d01bf271b/server/list_stations.sh /usr/local/hilbert-ui/server/scripts/list_stations.sh

# NOTE: The following is temporary, only before Dashboard server switches to use hilbert cfg_query directly
COPY scripts/list_stations.sh /usr/local/hilbert-ui/server/scripts/

# configure nginx
COPY hilbert-ui /etc/nginx/sites-enabled/

# configure services for baseimage-docker's init system
#RUN echo "#!/bin/sh\nnginx" > /etc/rc.local

#RUN mkdir -p /etc/service/hilbert_ui_api \
#    && echo "#!/bin/sh\ncd /usr/local/hilbert-ui/server/app\nexec node main.js" > /etc/service/hilbert_ui_api/run \
#    && chmod +x  /etc/service/hilbert_ui_api/run

# main entry point
COPY nginx.sh run.sh uiserver.sh /usr/local/

ENV HOME /root



ARG IMAGE_VERSION=latest
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
