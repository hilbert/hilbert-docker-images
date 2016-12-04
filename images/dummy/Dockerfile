FROM hilbert/x11

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh \
                        p7zip-full curl wget pciutils && \
    clean.sh

COPY test_nv.sh test_vbox.sh setup_nv.sh setup_vb.sh setup_alsa.sh customize.sh ilkh.sh /usr/local/bin/

# VOLUME /

