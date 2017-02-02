FROM hilbert/baseimage
#~~phusion/baseimage:0.9.18~~

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.base@gmail.com>

COPY update.sh install.sh upgrade.sh clean.sh /usr/local/bin/

# Update & Install & Clean up APT
# Not: please if possible add all the packages to the following single install command!
RUN update.sh && upgrade.sh \
 && install.sh bash wget curl git cups-bsd p7zip-full pciutils bzip2 \
 && clean.sh

# dist-upgrade ?

### RUN groupadd -r ur && useradd -r -g ur ur
#RUN groupadd -f -g 1000 ur
#RUN adduser --disabled-login --uid 1000 --gid 1000 --gecos 'non-root-user' ur
#RUN usermod -a -G sudo ur
#RUN mkdir -p /etc/sudoers.d && echo "ur ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ur && chmod 0440 /etc/sudoers.d/ur
# USER ur
# ENV HOME /home/ur
### VOLUME $HOME # ?
# WORKDIR $HOME

COPY setup_ogl.sh hb.sh hb_wrapper.sh config_cups.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/config_cups.sh

# RUN locale-gen de_DE.utf8 && locale-gen ru_RU.utf8

#ADD https://raw.githubusercontent.com/phusion/baseimage-docker/master/image/bin/my_init /sbin/my_init
#RUN chmod +x /sbin/my_init

# Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]

## ENTRYPOINT ["/sbin/my_init"]


