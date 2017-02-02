FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.gui@gmail.com>

# ENV LIBGL_DEBUG verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN update.sh \
 && install.sh \
       alsa alsa-tools alsa-utils alsamixergui pulseaudio libasound2 \
       xauth xterm x11-apps unclutter xdotool xinput \
       libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 libxv1 \
       libglapi-mesa libgles1-mesa libgles2-mesa libgl1-mesa-dri libgl1-mesa-glx \
       libglu1 libglu1-mesa freeglut3 \
       libegl1-mesa-drivers mesa-vdpau-drivers mesa-utils \
       mtdev-tools libmtdev-dev libmtdev1 \
       gstreamer1.0-plugins-bad gstreamer1.0-nice gstreamer1.0-plugins-good gstreamer1.0-plugins-base \
       gstreamer1.0-plugins-ugly gstreamer1.0-tools gstreamer1.0-vaapi gstreamer1.0-alsa \
       ca-certificates \
       dbus-x11 dbus libdbus-glib-1-2 libdbusmenu-glib4 \
       libnotify-bin \
       gconf-service libgconf-2-4 libnspr4 libnss3 libpango1.0-0 libxss1 fonts-liberation libappindicator1 xdg-utils \
       libindicator7 libgtk2.0-0 libxtst6 libexif12 \
       libcanberra-gtk3-module \
       libqt4-core libqt4-gui \
       python3-software-properties software-properties-common python3-pip \
 && pip3 install --upgrade pip && pip install --upgrade setuptools \
 && clean.sh


# g3dviewer gedit
# gtk2.0-examples qt4-qtconfig
# build-essential

RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
RUN ln -s /usr/src/xfullscreen/xfullscreen /usr/local/bin/

# RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
# RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean
COPY qclosebutton launch.sh x_64x64.png /usr/local/bin/
# NOTE: qclosebutton is a blob for now (building requires more packages... see :appchoo)
