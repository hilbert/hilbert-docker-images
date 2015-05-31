FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install p7zip-full curl wget pciutils

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 libxv1 libglapi-mesa

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
libgl1-mesa-dri libgl1-mesa-glx libglu1-mesa libgles1-mesa libgles2-mesa libegl1-mesa-drivers \
mesa-vdpau-drivers freeglut3 mesa-utils libglu1 
# libgl1 libgles2 ??

# xorg-video-abi-18
# xserver-xorg-core \
# xorg-video-abi-19 

COPY test_nv.sh test_vbox.sh setup_nv.sh setup_vb.sh setup.sh ilkh.sh /usr/local/bin/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VOLUME /

