FROM hilbert/xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh --no-install-recommends xcompmgr compton && clean.sh

# ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

COPY x11comp.sh /usr/local/bin/
