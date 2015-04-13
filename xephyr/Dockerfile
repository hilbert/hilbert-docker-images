FROM malex984/dockapp:x11
MAINTAINER Christian Stussak <stussak@mfo.de>

# RUN apt-get -y update
RUN apt-get -qqy install  mesa-dri-swrast xorg-server-xephyr xkeyboard-config xkbcomp

ADD startXephyr.sh /usr/local/bin/


## ENTRYPOINT [ "/startXephyr.sh" ]
