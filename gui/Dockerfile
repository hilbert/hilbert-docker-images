FROM malex984/dockapp:xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends \
            xdotool libqt4-core libqt4-gui xcompmgr compton libx11-6 \
	    libxcomposite1 libxdamage1 libxext6 libxfixes3 libxmu6 libxt6 libxv1 \
	    libglapi-mesa && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# g3dviewer gedit
# gtk2.0-examples qt4-qtconfig
# build-essential

RUN git clone https://github.com/IMAGINARY/xfullscreen.git /usr/src/xfullscreen/
RUN ln -s /usr/src/xfullscreen/*fullscreen /usr/local/bin/

# RUN git clone https://github.com/IMAGINARY/qclosebutton.git /usr/src/qclosebutton/
# RUN cd /usr/src/qclosebutton && qmake && make && cp qclosebutton /usr/local/bin/ && make clean
COPY qclosebutton launch.sh x_64x64.png /usr/local/bin/




