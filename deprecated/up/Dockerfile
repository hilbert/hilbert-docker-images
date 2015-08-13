FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOCKER_HOST unix:///var/run/docker.sock
ENV NO_PROXY /var/run/docker.sock

COPY customize.sh test_nv.sh test_vbox.sh up_nv.sh up_vb.sh ilkh.sh Dockerfile_nv Dockerfile_vb /usr/local/bin/

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh

