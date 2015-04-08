FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xorg
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xephyr

VOLUME /tmp/.X11-unix/
### same for x11vb # ?

COPY Xorg.sh /usr/local/bin/

# CMD Xorg
## --privileged --net host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /run/udev:/run/udev

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
