ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.test@gmail.com>

ENV LIBGL_DEBUG verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN update.sh && install.sh glmark2 g3dviewer nux-tools && clean.sh

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

#  xpratest

ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/test/Dockerfile"
LABEL org.label-schema.description="Applications and scripts for testing Graphics & GPU" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0"     

ONBUILD LABEL org.label-schema.build-date="" \
      org.label-schema.name="" \
      org.label-schema.description="" \
      org.label-schema.vendor="" \
      org.label-schema.url="" \
      org.label-schema.vcs-ref="" \
      org.label-schema.vcs-url="" \
      org.label-schema.version="" \
      org.label-schema.schema-version="" \
      com.microscaling.license="" \
      com.microscaling.docker.dockerfile="" \
      IMAGE_VERSION="" \
      GIT_NOT_CLEAN_CHECK=""

