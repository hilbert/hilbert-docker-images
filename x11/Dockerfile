FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xorg xserver-xorg-video-all
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
libgl1-mesa-dri libgl1-mesa-glx libglu1-mesa libgles1-mesa libgles2-mesa libegl1-mesa-drivers \
mesa-vdpau-drivers freeglut3 mesa-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xephyr 
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xcompmgr compton
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xauth x11-xserver-utils
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install openbox
# unagi
## compiz  
#  libx11 libxmu libxi

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 libxv1 libglapi-mesa

# VOLUME /tmp/.X11-unix/

# see testXephyr.sh
COPY Xorg.sh startXephyr.sh /usr/local/bin/
COPY .xinitrc /root/
COPY .xinitrc /

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz
# COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net=host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ 
#### -v /run/udev:/run/udev #???

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# xcm?
# git://people.freedesktop.org/~ajax/xcm

