FROM malex984/dockapp:x11

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install dkms build-essential 

#COPY ilkh.sh /tmp/
# $(uname -r | sed 's@-generic@@')
#RUN chmod +x /tmp/ilkh.sh && /tmp/ilkh.sh && rm /tmp/ilkh.sh

# ENV VBOX_VERSION    4.3.26
# currently the latest Virtual Box Guest Additions...
# ADD http://dlc-cdn.sun.com/virtualbox/4.3.26/VirtualBox-4.3.26-98988-Linux_amd64.run /usr/src/
## ADD VirtualBox-4.3.26-98988-Linux_amd64.run /tmp/

# RUN chmod +x /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
# RUN /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
# RUN rm /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
# ther special cleanup...????

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



#ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/GPU_Test_Info_Linux64.tar.gz

# TODO: services?
# CMD Xorg


#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libgles1-mesa libgles2-mesa libegl1-mesa-drivers libgl1-mesa-dri mesa-vdpau-drivers
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install nux-tools mesa-utils
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install glmark2


# ENV VBOX_VERSION    4.3.26
## ADD VirtualBox-4.3.26-98988-Linux_amd64.run /tmp/
# ADD http://dlc-cdn.sun.com/virtualbox/4.3.26/VirtualBox-4.3.26-98988-Linux_amd64.run /usr/src/
#ADD VBoxLinuxAdditions.run /tmp/
#RUN chmod +x /tmp/VBoxLinuxAdditions.run && /tmp/VBoxLinuxAdditions.run && rm /tmp/VBoxLinuxAdditions.run || rm /tmp/VBoxLinuxAdditions.run

