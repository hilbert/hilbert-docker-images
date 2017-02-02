FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.x11vnc@gmail.com>

RUN update.sh && install.sh x11vnc && clean.sh

# VOLUME /tmp/.X11-unix/
COPY x11vnc.sh /usr/local/bin/

# ENV HOME /root
# RUN mkdir "$HOME/.vnc"
# Setup a password
# RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# x11vnc -usepw -forever

EXPOSE 5900-5910

