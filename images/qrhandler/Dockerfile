FROM hilbert/xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh x11-utils xinput evemu-tools mtdev-tools scrot && clean.sh

COPY action.sh event qrhandler.sh /usr/local/bin/


