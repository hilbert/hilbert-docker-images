FROM malex984/dockapp:xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install g3dviewer gedit
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install gtk2.0-examples qt4-qtconfig

### TODO: apulse!!!

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

