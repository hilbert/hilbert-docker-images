FROM malex984/dockapp:x11

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install p7zip-full curl wget pciutils

COPY test_nv.sh test_vbox.sh setup_nv.sh setup_vb.sh customize.sh ilkh.sh /usr/local/bin/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VOLUME /

