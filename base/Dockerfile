FROM phusion/baseimage

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Use baseimage-docker's init system.
ENTRYPOINT ["/sbin/my_init"]

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# dist-upgrade ?
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive apt-get -y aptitude

### RUN groupadd -r ur && useradd -r -g ur ur
#RUN groupadd -f -g 1000 ur
#RUN adduser --disabled-login --uid 1000 --gid 1000 --gecos 'non-root-user' ur
#RUN usermod -a -G sudo ur
#RUN mkdir -p /etc/sudoers.d && echo "ur ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ur && chmod 0440 /etc/sudoers.d/ur
# USER ur
# ENV HOME=/home/ur
### VOLUME $HOME # ?
# WORKDIR $HOME

# Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
