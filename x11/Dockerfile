FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xorg xserver-xorg-video-all
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libgles1-mesa libgles2-mesa libegl1-mesa-drivers libgl1-mesa-dri mesa-vdpau-drivers freeglut3 libgl1-mesa-glx libglu1-mesa
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install nux-tools mesa-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xephyr xcompmgr unagi
## compiz  
#  libx11 libxmu libxi

# VOLUME /tmp/.X11-unix/

COPY Xorg.sh /usr/local/bin/
# see testXephyr.sh
COPY startXephyr.sh /usr/local/bin/

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz
# COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net=host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ 
#### -v /run/udev:/run/udev #???

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# xcm?
# git://people.freedesktop.org/~ajax/xcm

