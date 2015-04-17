FROM malex984/dockapp:x11

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install dkms build-essential 

#### $(uname -r)  ### UPDATE: same headers as the host kernel ! :(


RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install linux-headers-generic
#  linux-headers-3.13.0-48
## linux-headers-$(uname -r)


# ENV VBOX_VERSION    4.3.26

# currently the latest Virtual Box Guest Additions...
ADD http://dlc-cdn.sun.com/virtualbox/4.3.26/VirtualBox-4.3.26-98988-Linux_amd64.run /usr/src/
### ADD VirtualBox-4.3.26-98988-Linux_amd64.run /usr/src/
## RUN chmod +x /usr/src/VirtualBox-4.3.26-98988-Linux_amd64.run && 
#RUN /usr/src/VirtualBox-4.3.26-98988-Linux_amd64.run
#RUN rm /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
# ther special cleanup...????

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/GPU_Test_Info_Linux64.tar.gz

# TODO: services?
# CMD Xorg
