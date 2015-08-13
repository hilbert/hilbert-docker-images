FROM malex984/dockapp:xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install openarena

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
