FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Install OMD, see http://labs.consol.de/OMD/
RUN gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7 && \
    gpg --armor --export F8C1CA08A57B9ED7 | apt-key add -

#echo 'deb http://labs.consol.de/repo/testing/ubuntu trusty main' >> /etc/apt/sources.list
RUN echo 'deb http://labs.consol.de/repo/stable/ubuntu trusty main' >> /etc/apt/sources.list

RUN update.sh && install.sh \
    libpython2.7 omd net-tools netcat xinetd  \
    && clean.sh


# Install the agent to monitor localhost
## http://mathias-kettner.de/download/check-mk-agent_1.2.4p5-2_all.deb
#RUN wget https://mathias-kettner.de/support/1.2.6p12/check-mk-raw-1.2.6p12_0.trusty_amd64.deb -P /tmp/
#RUN dpkg -i /tmp/check-mk-raw-1.2.6p12_0.trusty_amd64.deb
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

# We don't want TMPFS as it requires higher privileges
RUN omd config default set TMPFS off
### RUN sed "s/CONFIG_TMPFS='on'/CONFIG_TMPFS='off'/" -i /omd/sites/default/etc/omd/site.conf 

# Accept connections on any IP address, since we get a random one
RUN omd config default set APACHE_TCP_ADDR 0.0.0.0

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

# Add scripts to start services in baseimage my_init:
COPY 10_startup_base_services 20_startup_omd_master /etc/my_init.d/
COPY omd_entrypoint.sh /usr/local/bin/

# Set up runtime options
EXPOSE 80 6556 5000

## ENTRYPOINT ["omd_entrypoint.sh"]


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




############## https://github.com/SpringerSBM/basic-docker-omd
