FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.kivy@gmail.com>

# http://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer

RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A863D2D6 && \
    DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:kivy-team/kivy && \
    update.sh && install.sh python-kivy python-numpy && clean.sh
# TODO: python3?

RUN git clone https://github.com/stocyr/Deflectouch.git /usr/local/src/Deflectouch/
COPY run.sh /usr/local/src/Deflectouch/

## http://kivy.org/docs/api-kivy.input.providers.probesysfs.html#module-kivy.input.providers.probesysfs
## http://kivy.org/docs/api-kivy.input.providers.mtdev.html
## https://wiki.ubuntu.com/Multitouch
## https://launchpad.net/canonical-multitouch

# RUN update.sh && install.sh alsamixergui pulseaudio && clean.sh

# WORKDIR /usr/local/src/Deflectouch/
