FROM hilbert/dd

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.omd_agent@gmail.com>

ADD check-mk-agent_1.2.6p12-1_all.deb /tmp/check-mk-agent.deb

RUN update.sh && install.sh xinetd && dpkg -i /tmp/check-mk-agent.deb && install.sh -fy && clean.sh

COPY check_dockapp.sh /usr/local/lib/nagios/plugins/
RUN cd /usr/local/lib/nagios/plugins/ && \
ln -s check_dockapp.sh check_dockapp_back.sh && \
ln -s check_dockapp.sh check_dockapp_exited.sh && \
ln -s check_dockapp.sh check_dockapp_foreign.sh && \
ln -s check_dockapp.sh check_dockapp_top1.sh && \
ln -s check_dockapp.sh check_dockapp_heartbeat.sh

EXPOSE 6556
EXPOSE 8888

COPY logwatch.cfg mrpe.cfg /etc/check_mk/
COPY omd_agent_entrypoint.sh /usr/local/bin/

#RUN git clone https://github.com/hilbert/hilbert-heartbeat.git /usr/local/src
ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/devel/server/heartbeat2.py /usr/local/bin/heartbeat2.py
ADD https://raw.githubusercontent.com/hilbert/hilbert-heartbeat/devel/server/heartbeat3.py /usr/local/bin/heartbeat3.py

# VOLUME ...?

