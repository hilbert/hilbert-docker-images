ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.dd@gmail.com>

RUN update.sh && \
    curl -sSL https://get.docker.com/gpg | apt-key add - && \
    curl -sSL https://get.docker.com/ | sh && \
    clean.sh

#ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /usr/local/bin/docker
#RUN chmod +x /usr/local/bin/docker

#RUN curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose 
#RUN chmod +x /usr/local/bin/docker-compose

# RUN chmod +x /usr/local/bin/docker /usr/local/bin/docker-compose
# RUN ln -s $HOME/bin/docker-latest $HOME/bin/docker
## ENV DOCKER_CERT_PATH 

# nsenter does not work from inside a container :(
# ADD ./baseimage-docker-nsenter ./docker-bash /usr/local/bin/

ENV DOCKER_HOST unix:///var/run/docker.sock
ENV NO_PROXY /var/run/docker.sock

# RUN groupadd -f -g 998 docker
# RUN usermod -a -G docker ur
# USER ur
# ENV HOME /home/ur
# VOLUME $HOME
# WORKDIR $HOME

# limit due to current docker client:
ENV DOCKER_API_VERSION 1.24



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/dd/Dockerfile"
LABEL org.label-schema.description="contains docker client - serves as a basis for images requiring interaction with the docker engine" \
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

