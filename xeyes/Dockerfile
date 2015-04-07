FROM malex984/dockapp:alsa

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xauth 
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install x11-apps
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install rxvt-unicode
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xdotool

ENV XLIB_SKIP_ARGB_VISUALS 1
ENV QT_X11_NO_MITSHM 1
ENV DISPLAY :0

# CMD /usr/bin/xeyes

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


