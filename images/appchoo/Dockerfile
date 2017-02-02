FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.appchoo@gmail.com>

# ENV LIBGL_DEBUG verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN update.sh && install.sh libsdl-image1.2 libsdl-ttf2.0 libsdl-gfx1.2 && clean.sh

#RUN git clone https://github.com/malex984/appchoo.git /usr/src/appchoo/
#### building requires installing more packages: build-essential & *-dev (& imagemagic?)
#RUN cd /usr/src/appchoo && make && cp appchoo /usr/local/bin/ && make clean

### Oh, well... Blobs for now
COPY appchoo menu.sh txt2jpg.sh FreeMonoBold.ttf /usr/local/bin/

