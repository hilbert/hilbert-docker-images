FROM hilbert/test

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# http://kivy.org/docs/installation/installation-linux.html#ubuntu-11-10-or-newer

RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A863D2D6 && \
    DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:kivy-team/kivy && \
    update.sh && install.sh \
       gstreamer1.0-plugins-bad gstreamer1.0-nice gstreamer1.0-plugins-good gstreamer1.0-plugins-base \
       gstreamer1.0-plugins-ugly gstreamer1.0-tools gstreamer1.0-vaapi gstreamer1.0-alsa \
       mtdev-tools libmtdev-dev libmtdev1 \
       python-kivy python-numpy \
       dbus-x11 dbus libdbus-glib-1-2 libdbusmenu-glib4  \
    && \
    clean.sh

RUN git clone https://github.com/stocyr/Deflectouch.git /usr/local/src/Deflectouch/
COPY run.sh /usr/local/src/Deflectouch/

## http://kivy.org/docs/api-kivy.input.providers.probesysfs.html#module-kivy.input.providers.probesysfs
## http://kivy.org/docs/api-kivy.input.providers.mtdev.html
## https://wiki.ubuntu.com/Multitouch
## https://launchpad.net/canonical-multitouch

RUN update.sh && install.sh alsamixergui pulseaudio && clean.sh

# WORKDIR /usr/local/src/Deflectouch/
