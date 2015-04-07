FROM malex984/dockapp:x11

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN apt-get install -q -y dkms build-essential 

#### $(uname -r)  ### UPDATE: same headers as the host kernel ! :(
RUN apt-get install -q -y linux-headers-generic linux-headers-3.13.0-48

ADD ["http://dlc-cdn.sun.com/virtualbox/4.3.26/VirtualBox-4.3.26-98988-Linux_amd64.run" "/tmp/"]
# ADD VirtualBox-4.3.26-98988-Linux_amd64.run /tmp/
RUN chmod +x /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run && /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
RUN rm /tmp/VirtualBox-4.3.26-98988-Linux_amd64.run
# ther special cleanup...????

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: services?
# CMD Xorg
