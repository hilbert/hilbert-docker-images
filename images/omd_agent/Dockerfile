FROM hilbert/dd

MAINTAINER Oleksandr Motsak <malex984+hilbert.omd_agent@gmail.com>

ADD check-mk-agent_1.2.6p12-1_all.deb /tmp/check-mk-agent.deb

RUN update.sh && install.sh xinetd && dpkg -i /tmp/check-mk-agent.deb && install.sh -fy && clean.sh

COPY check_hilbert.sh /usr/local/lib/nagios/plugins/
RUN cd /usr/local/lib/nagios/plugins/ && \
ln -s check_hilbert.sh check_hilbert_back.sh && \
ln -s check_hilbert.sh check_hilbert_exited.sh && \
ln -s check_hilbert.sh check_hilbert_foreign.sh && \
ln -s check_hilbert.sh check_hilbert_top1.sh && \
ln -s check_hilbert.sh check_hilbert_heartbeat.sh

EXPOSE 6556
EXPOSE 8888

COPY logwatch.cfg mrpe.cfg /etc/check_mk/
COPY omd_agent_entrypoint.sh /usr/local/bin/

#RUN git clone https://github.com/hilbert/hilbert-heartbeat.git /usr/local/src
ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/devel/server/heartbeat2.py /usr/local/bin/heartbeat2.py
ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/devel/server/heartbeat3.py /usr/local/bin/heartbeat3.py

# VOLUME ...?




ARG IMAGE_VERSION=latest
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
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"
