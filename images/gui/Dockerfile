ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.gui@gmail.com>

# ENV LIBGL_DEBUG verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN update.sh \
 && install.sh python3-software-properties software-properties-common python3-pip dbus \
 && DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:graphics-drivers/ppa && update.sh \
 && install.sh \
       alsa alsa-tools alsa-utils alsamixergui pulseaudio libasound2 pavucontrol \
       xauth xterm x11-apps unclutter xdotool xinput wmctrl x11-xserver-utils x11-utils arandr \
       libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxi6 libxxf86vm1 libxcomposite1 libxdamage1 libxfixes3 libxmu6 libxt6 libxv1 \
       libglew1.10 libglu1 freeglut3 libvdpau-va-gl1 \
       libglapi-mesa libglu1-mesa libgles1-mesa libgles2-mesa libgl1-mesa-dri libgl1-mesa-glx libegl1-mesa-drivers mesa-vdpau-drivers mesa-utils \
       mtdev-tools libmtdev-dev libmtdev1 \
       gstreamer1.0-plugins-bad gstreamer1.0-nice gstreamer1.0-plugins-good gstreamer1.0-plugins-base \
       gstreamer1.0-plugins-ugly gstreamer1.0-tools gstreamer1.0-vaapi gstreamer1.0-alsa \
       dbus-x11 libdbus-glib-1-2 libdbusmenu-glib4 \
       libnotify-bin \
       gconf-service libgconf-2-4 libnspr4 libnss3 libpango1.0-0 libxss1 fonts-liberation libappindicator1 xdg-utils \
       libindicator7 libgtk2.0-0 libxtst6 libexif12 \
       libcanberra-gtk3-module \
       libqt4-core libqt4-gui \
       compton \
 && pip3 install --upgrade pip && pip install --upgrade setuptools \
 && upgrade.sh \
 && clean.sh

# g3dviewer gedit
# gtk2.0-examples qt4-qtconfig
# build-essential

RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
RUN ln -s /usr/src/xfullscreen/xfullscreen /usr/local/bin/

# RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
# RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean
COPY qclosebutton x_64x64.png /usr/local/bin/
# NOTE: qclosebutton is a blob for now (building requires more packages... see :appchoo)

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
ENV PATH /usr/local/nvidia/bin:${PATH}

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
#   ldconfig

####################################################################################################

ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/gui/Dockerfile"
LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.description="serves as a base for all GUI/3D-related images (hopefully with dbus and multi-touch support)" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}"

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
