FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

COPY main.sh menu.sh run.sh sv.sh A.sh /usr/local/bin/

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xauth

ENV DOCKER_HOST unix:///var/run/docker.sock 
ENV NO_PROXY /var/run/docker.sock

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
