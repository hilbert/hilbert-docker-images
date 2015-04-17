FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xorg
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xephyr
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libgles1-mesa libgles2-mesa libegl1-mesa-drivers libgl1-mesa-dri mesa-vdpau-drivers
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install nux-tools mesa-utils

# VOLUME /tmp/.X11-unix/

COPY Xorg.sh /usr/local/bin/
# see testXephyr.sh
COPY startXephyr.sh /usr/local/bin/

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz

COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /run/udev:/run/udev

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
