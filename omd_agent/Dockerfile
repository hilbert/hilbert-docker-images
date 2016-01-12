FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh --no-install-recommends xinetd python2.7 && clean.sh
ADD check-mk-agent_1.2.6p12-1_all.deb /tmp/check-mk-agent.deb
RUN update.sh && dpkg -i /tmp/check-mk-agent.deb && install.sh -fy && clean.sh

COPY check_dockapp.sh /usr/local/lib/nagios/plugins/
RUN cd /usr/local/lib/nagios/plugins/ && \
ln -s check_dockapp.sh check_dockapp_back.sh && \
ln -s check_dockapp.sh check_dockapp_exited.sh && \
ln -s check_dockapp.sh check_dockapp_foreign.sh && \
ln -s check_dockapp.sh check_dockapp_top1.sh && \
ln -s check_dockapp.sh check_dockapp_heartbeat.sh

COPY logwatch.cfg mrpe.cfg /etc/check_mk/
COPY heartbeat2.py omd_agent_entrypoint.sh /usr/local/bin/

EXPOSE 6556
EXPOSE 8888

# VOLUME ...?
