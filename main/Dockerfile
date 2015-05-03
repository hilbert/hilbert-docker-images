FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xauth

ENV DOCKER_HOST unix:///var/run/docker.sock 
ENV NO_PROXY /var/run/docker.sock

COPY main.sh menu.sh run.sh sv.sh A.sh test_nv.sh test_vbox.sh /usr/local/bin/
COPY up_nv.sh up_vb.sh ilkh.sh Dockerfile_nv Dockerfile_vb /usr/src/

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
