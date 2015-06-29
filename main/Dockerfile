FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends \
                                   xauth && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY main.sh menu.sh run.sh sv.sh A.sh generate_ogl.sh /usr/local/bin/

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh
