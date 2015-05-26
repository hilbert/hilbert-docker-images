FROM malex984/dockapp:xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install g3dviewer gedit
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install gtk2.0-examples qt4-qtconfig

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xdotool
RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
RUN ln -s /usr/src/xfullscreen/*fullscreen /usr/local/bin/

### libqt4??
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libqt4-core libqt4-gui
# qt4-default 
# qt4-qmake

#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install build-essential
#RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
#RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xcompmgr compton
COPY qclosebutton launch.sh x_64x64.png /usr/local/bin/

# https://github.com/chjj/compton
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libx11 libxcomposite libxdamage libxfixes libXext libxrender libXrandr libXinerama
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xproto x11proto 
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install x11-utils
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libpcre libconfig libdrm libGL libdbus
# RUN git clone https://github.com/chjj/compton.git /usr/src/compton/


# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

