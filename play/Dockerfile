FROM malex984/dockapp:gui

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install cmus vlc mplayer2 gxine xine-ui

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
