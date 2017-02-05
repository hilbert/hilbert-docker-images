FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.test@gmail.com>

ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1


RUN update.sh && \
    install.sh \
          --no-install-recommends \
          libgles1-mesa libgles2-mesa libegl1-mesa-drivers mesa-vdpau-drivers \
	  freeglut3 nux-tools mesa-utils pciutils \
	  glmark2 libxv1 g3dviewer libcanberra-gtk3-module && \
    clean.sh

# build-essential
#  xkeyboard-config xkbcomp

#RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
#RUN ln -s /usr/src/xfullscreen/*fullscreen /usr/local/bin/

#  libsdl-image1.2-dev
#RUN git clone https://github.com/porst17/appchoo.git /usr/src/appchoo/
#RUN cd /usr/src/appchoo && make && cp appchoo /usr/local/bin/ && make clean


#  qt4-default qt4-qmake
#RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
#RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean

# ADD http://xdialog.free.fr/Xdialog-2.3.1.tar.bz2 /usr/src/

# TODO: Find corresponding tools or their analogs...
# ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/BM.tar.bz2 /usr/src/

# fbsuite seems to be rather outdated, and unusable on 64 bit ubuntu14.04 :(


COPY test_sys.sh ilkh.sh test_x11.sh test_nv.sh test_vbox.sh /usr/local/bin/
# xcm?
# git://people.freedesktop.org/~ajax/xcm


#  v4l-utils
#  gtk2.0-examples qt4-qtconfig gedit


# ADD http://www.forchheimer.se/transset-df/transset-df-6.tar.gz /usr/src/

# x11perf 
#ADD http://launchpadlibrarian.net/179163801/glmark2_2014.03-0ubuntu3_amd64.deb /usr/src/
#ADD http://launchpadlibrarian.net/179164175/glmark2-data_2014.03-0ubuntu3_all.deb /usr/src/
#RUN sudo dpkg -i /usr/src/glmark2-data_2014.03-0ubuntu3_all.deb
#RUN sudo dpkg -i /usr/src/glmark2_2014.03-0ubuntu3_amd64.deb


## http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz 
# python-tk
COPY GpuTest_Linux_x64_0.7.0.tar.bz2 /usr/src/
RUN tar -xjvf /usr/src/GpuTest_Linux_x64_0.7.0.tar.bz2 -C /usr/src/ && ln -s /usr/src/GpuTest_Linux_x64_0.7.0/GpuTest-all.sh /usr/local/bin/

# libgl libjpeg-turbo libpng12 libx11 libxcb python2
#  python2 ./waf configure --prefix=/usr --with-flavors x11-gl,x11-glesv2 &&  python2 ./waf &&  python2 ./waf install --destdir="$pkgdir/"
#  libgl libegl libpng12 libx11 libxcb
#ADD https://launchpad.net/glmark2/trunk/2014.03/+download/glmark2-2014.03.tar.gz /usr/src/

COPY bm_gpu.sh /usr/src/

#  xpra??

