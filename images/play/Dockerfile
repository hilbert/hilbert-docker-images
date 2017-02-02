FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.play@gmail.com>

RUN update.sh && install.sh cmus vlc mplayer2 gxine xine-ui && clean.sh
# mpv?
