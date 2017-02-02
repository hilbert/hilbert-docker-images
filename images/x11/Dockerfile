FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.x11@gmail.com>

RUN update.sh \
 && install.sh xserver-xorg xserver-xorg-video-all xserver-xephyr x11-xserver-utils xinit xvfb openbox \
 && clean.sh

# libgl1 libgles2 ??

# xorg-video-abi-18
# xserver-xorg-core \
# xorg-video-abi-19 
# unagi
#- compiz  
#- x11vnc 
#!  libx11 libxmu 
## libxi?


# VOLUME /tmp/.X11-unix/

# see testXephyr.sh
COPY Xorg.sh startXephyr.sh /usr/local/bin/

COPY .xinitrc /root/
#COPY .xinitrc /

RUN sed -i -e 's@^ *allowed_users=.*$@allowed_users=anybody@g' /etc/X11/Xwrapper.config

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz
# COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net=host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ 
#### -v /run/udev:/run/udev #???

# xcm?
# git://people.freedesktop.org/~ajax/xcm

