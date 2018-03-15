ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.omd@gmail.com>

# Install OMD, see http://labs.consol.de/OMD/
RUN gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7 && \
    gpg --armor --export F8C1CA08A57B9ED7 | apt-key add - && \
    echo 'deb http://labs.consol.de/repo/stable/ubuntu trusty main' >> /etc/apt/sources.list
    
RUN update.sh \
&& install.sh \
    ssl-cert libpython2.7 net-tools netcat xinetd at \
    time traceroute libsnmp-python dialog dnsutils \
    fping graphviz libapache2-mod-fcgid libapache2-mod-proxy-html \
    apache2-mpm-prefork apache2-utils \
    libboost-program-options1.54.0 libboost-system1.54.0 libdbi1 \
    libevent-1.4-2 libnet-snmp-perl libpango1.0-0 libreadline5 \
    libsnmp-perl mysql-server patch php5-cli \
    php5-cgi libradiusclient-ng2 php5-gd php5-mcrypt \
    php5-sqlite php-pear pyro rsync smbclient snmp unzip xvfb python-ldap \
&& wget "http://files.omdistro.org/releases/1.30/omd-1.30.trusty.amd64.deb" -P /tmp/ \
&& dpkg -i /tmp/omd-1.30.trusty.amd64.deb \
&& install.sh -fy \
&& clean.sh
    

#### due to http://www.monitoring-portal.org/wbb/index.php?page=Thread&threadID=32891
#### http://labs.consol.de/repo/testing/ubuntu (instead of stable) 
#### is supposed to provide Icinga 2...


# Install the agent to monitor localhost
## http://mathias-kettner.de/download/check-mk-agent_1.2.4p5-2_all.deb
## check-mk-agent_1.2.4p5-2_all.deb


RUN echo yes | omd setup
RUN a2enmod proxy && a2enmod proxy_http
# /usr/sbin/setsebool httpd_can_network_connect 1


# Fix some stuff in apache: no change ulimit and give the server a name
RUN echo "APACHE_ULIMIT_MAX_FILES=true" >> /etc/apache2/envvars
RUN echo ServerName basic-docker-omd > /etc/apache2/conf-available/docker-servername.conf
RUN a2enconf docker-servername


### Fix warning in syslog-ng in ubuntu 13.10:
## https://bugs.launchpad.net/ubuntu/+source/syslog-ng/+bug/1009920
## RUN sed -i 's/^SYSLOGNG_OPTS.*/SYSLOGNG_OPTS="--no-caps --default-modules=affile,afprog,afsocket,afuser,basicfuncs,csvparser,dbparser,syslogformat"/' /etc/default/syslog-ng


#####################################################################################
# Setup the initial OMD site 'default'
#
# This method is a little bit hacky, and I had to do some workarounds:
#  1. tmpfs is not supported by standard docker (can be recompiled). 
#    In OMD can be disabled, but I don't know how to do it before initilize the site. 
#
#    Solution: try to create the site and change the config after.
# 
#  2. Second issue: the new user created by OMD needs to be in the group crontab 
#     to be able to change the cronjobs. But you need first to get the user to change it!

# Set up a default site
RUN omd create default || true

### RUN sed "s/CONFIG_TMPFS='on'/CONFIG_TMPFS='off'/" -i /omd/sites/default/etc/omd/site.conf 

# * We don't want TMPFS as it requires higher privileges
# * Accept connections on any IP address, since we get a random one

RUN omd config default set TMPFS "off" && \
 omd config default set ADMIN_MAIL "malex984+omd@gmail.com" && \
 omd config default set LIVESTATUS_TCP "on" && \
 omd config default set MKEVENTD "on"  && \
 omd config default set NAGIOS_THEME "classicui"  && \
 omd config default set NAGVIS_URLS "nagios"  && \
 omd config default set NSCA "on"  && \
 omd config default set PNP4NAGIOS "on"  && \
 omd config default set APACHE_TCP_ADDR "0.0.0.0"  && \
 omd config default set CORE "nagios"  && \
 omd config default set CRONTAB "on"  && \
 omd config default set DEFAULT_GUI "welcome"  && \
 omd config default set DOKUWIKI_AUTH "off" 
# && \
# omd config default set MOD_GEARMAN "off"  && \
# omd config default set MONGODB "off"  && \
# omd config default set MULTISITE_AUTHORISATION "off"  && \
# omd config default set MULTISITE_COOKIE_AUTH "off"  && \
# omd config default set MYSQL "off"  && \
# omd config default set THRUK_COOKIE_AUTH "off" 
# omd config default set LIVESTATUS_TCP_PORT "6557" && \
# omd config default set APACHE_TCP_PORT "5000"  && \
# omd config default set AUTOSTART "on"  && \
# omd config default set NSCA_TCP_PORT "5667"  && \
# omd config default set APACHE_MODE "own"  && \
# && \

#RUN omd config default set TMPFS "Cleaning up temp filesystem...OK"
# omd config default set MKEVENTD_SNMPTRAP "off"  && \
# omd config default set MKEVENTD_SYSLOG "off"  && \
# omd config default set MKEVENTD_SYSLOG_TCP "off"  && \

## RUN omd config default set CORE "icinga"
## RUN omd config default set NAGVIS_URLS "check_mk"
RUN omd config default show

# Add the new user to crontab, to avoid error merging crontabs
RUN adduser default crontab 

#####################################################################################
# Initial configuration of the site and image

# Add localhost as node monitored
#?# ADD hosts.mk /omd/sites/default/etc/check_mk/conf.d/wato/hosts.mk

# First OMD service discovery and compile
# RUN /etc/init.d/xinetd start && su - default -c "cmk -II"
# RUN su - default -c "cmk -R"
####su - default -c 'cmd -u -II && cmk -R'

# Fix some permission issues (not sure why it happens)
RUN chown -R default.default /omd/sites/default

# Set up runtime options
EXPOSE 80
EXPOSE 514
EXPOSE 6556
EXPOSE 5667
EXPOSE 5000

# http://omdistro.org/doc/generic_quickstart
# http://omdistro.org/doc/configuration_basics
# http://omdistro.org/start

# check the web frontend: http://myhost/mysite/nagios. The default web user is omdadmin / omd
# To find out the IP address, run ip addr in the container shell.

# omd status
# cat  /etc/apache2/conf.d/zzz_omd.conf
# omd create foo
# omd create mysite && omd start foo
# mount



# Add scripts to start services in baseimage my_init:
## COPY 10_startup_base_services 20_startup_omd_master /etc/my_init.d/
COPY omd_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/omd_entrypoint.sh

## ENTRYPOINT ["omd_entrypoint.sh"]

############## https://github.com/SpringerSBM/basic-docker-omd




ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/omd/Dockerfile"
LABEL org.label-schema.description="containes pre-cofigured OMD service instance" \
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

