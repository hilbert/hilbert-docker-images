ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}
### FROM hilbert/dd

MAINTAINER Oleksandr Motsak <malex984+hilbert.omd_agent@gmail.com>

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

#ENV DOCKER_HOST unix:///var/run/docker.sock
#ENV NO_PROXY /var/run/docker.sock

# RUN groupadd -f -g 998 docker
# RUN usermod -a -G docker ur
# USER ur
# ENV HOME /home/ur
# VOLUME $HOME
# WORKDIR $HOME

# limit due to current docker client:
ENV DOCKER_API_VERSION 1.24

RUN update.sh \
 && install.sh xinetd \
 && wget -q "https://cloud.imaginary.org/index.php/s/WSGU4yEaR4RaH3T/download?path=%2F&files=check-mk-agent_1.2.6p12-1_all.deb" -O /tmp/check-mk-agent.deb \
 && dpkg -i /tmp/check-mk-agent.deb \
 && install.sh -fy \
 && clean.sh

ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/v1.0.0/client/bash/check_heartbeat.sh /usr/local/lib/nagios/plugins/check_heartbeat.sh
COPY check_hilbert.sh check_hilbert_back.sh check_hilbert_foreign.sh check_hilbert_exited.sh check_hilbert_heartbeat.sh check_hilbert_top1.sh /usr/local/lib/nagios/plugins/

ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/v1.0.0/server/heartbeat.py /usr/local/bin/heartbeat.py

EXPOSE 6556
EXPOSE 8888

COPY logwatch.cfg mrpe.cfg /etc/check_mk/
COPY omd_agent_entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/heartbeat.py /usr/local/lib/nagios/plugins/* /usr/local/bin/omd_agent_entrypoint.sh



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/omd_agent/Dockerfile"
LABEL org.label-schema.description="containes pre-cofigured OMD/Check_MK Agent +check_hilbert.sh + HeartBeat server" \
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

