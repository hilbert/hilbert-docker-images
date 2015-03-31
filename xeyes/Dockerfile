FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Use baseimage-docker's init system.
ENTRYPOINT ["/sbin/my_init"]

RUN apt-get update
RUN apt-get install -qqy xauth x11-apps
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DISPLAY :0
CMD xeyes


