FROM malex984/dockapp:xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh openarena && clean.sh

# RUN update.sh && install.sh x11-xserver-utils && clean.sh

COPY q3.sh bench.sh /usr/local/bin/


