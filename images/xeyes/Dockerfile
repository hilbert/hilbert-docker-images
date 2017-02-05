FROM hilbert/alsa

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.xeyes@gmail.com>

RUN update.sh && install.sh --no-install-recommends \
	 xauth x11-apps xterm unclutter xdotool && \
    clean.sh

# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

# CMD /usr/bin/xeyes


