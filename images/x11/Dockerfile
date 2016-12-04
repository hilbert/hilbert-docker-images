FROM hilbert/xeyes

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && \
    install.sh \
                     xserver-xorg xserver-xorg-video-all \
                     libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
		     libxmu6 libxt6 libxv1 \
		     xserver-xephyr xauth x11-xserver-utils \
		     libgl1-mesa-dri libgl1-mesa-glx libglu1-mesa \
		     libgles1-mesa libgles2-mesa libegl1-mesa-drivers \
		     mesa-vdpau-drivers freeglut3 mesa-utils libglu1 libglapi-mesa \
		     xterm xinit x11-apps libglapi-mesa libglu1 \
                     xvfb openbox \
    && \
    clean.sh

## xcompmgr compton openbox 

    # libgl1 libgles2 ??

# xorg-video-abi-18
# xserver-xorg-core \
# xorg-video-abi-19 
# unagi
## compiz  
## x11vnc 
#  libx11 libxmu libxi





# VOLUME /tmp/.X11-unix/

# see testXephyr.sh
COPY Xorg.sh startXephyr.sh /usr/local/bin/

COPY .xinitrc /root/
#COPY .xinitrc /

RUN perl -pi -e 's@^ *allowed_users=.*$@allowed_users=anybody@' /etc/X11/Xwrapper.config

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz
# COPY xfullscreen/wmfullscreen xfullscreen/xfullscreen /usr/local/bin/

# CMD Xorg
## --privileged --net=host -v /dev/dri/:/dev/dri/ -v /dev/input/:/dev/input/ -v /tmp/.X11-unix/:/tmp/.X11-unix/ 
#### -v /run/udev:/run/udev #???

# xcm?
# git://people.freedesktop.org/~ajax/xcm

