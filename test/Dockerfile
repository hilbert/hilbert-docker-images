FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

##RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xserver-xorg-video-all
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xauth x11-apps 
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install rxvt-unicode

# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xcompmgr 
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xkeyboard-config xkbcomp
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install git

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xdotool

RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
RUN ln -s /usr/src/xfullscreen/*fullscreen /usr/local/bin/

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libsdl-image1.2-dev
RUN git clone https://github.com/porst17/appchoo.git /usr/src/appchoo/
RUN cd /usr/src/appchoo && make && cp appchoo /usr/local/bin/ && make clean


RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install qt4-default qt4-qmake 
RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean

COPY appchoo.bin qclosebutton.bin /usr/local/bin/

ADD http://xdialog.free.fr/Xdialog-2.3.1.tar.bz2 /usr/src/




# TODO: Find corresponding tools or their analogs...
ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/BM.tar.bz2 /usr/src/

# fbsuite seems to be rather outdated, and unusable on 64 bit ubuntu14.04 :(

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libgles1-mesa libgles2-mesa libegl1-mesa-drivers  mesa-vdpau-drivers freeglut3 
# libgl1-mesa-dri libgl1-mesa-glx libglu1-mesa 
## mesa-dri-swrast
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install nux-tools mesa-utils g3dviewer
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install pciutils

COPY test_sys.sh ilkh.sh test_x11.sh test_nv.sh test_vbox.sh /usr/local/bin/
# xcm?
# git://people.freedesktop.org/~ajax/xcm


# RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y v4l-utils


# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install gtk2.0-examples qt4-qtconfig gedit

# https://github.com/chjj/compton
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libx11 libxcomposite libxdamage libxfixes libXext libxrender libXrandr libXinerama
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install xproto x11proto 
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install x11-utils
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libpcre libconfig libdrm libGL libdbus
RUN git clone https://github.com/chjj/compton.git /usr/src/compton/

ADD http://www.forchheimer.se/transset-df/transset-df-6.tar.gz /usr/src/

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libxv1 x11perf glmark2 
COPY bm_gpu.sh /usr/src/

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install python-tk
ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/

