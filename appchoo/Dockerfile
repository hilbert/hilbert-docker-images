FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

ENV LIBGL_DEBUG=verbose
# ENV XLIB_SKIP_ARGB_VISUALS 1

# set the following if any QT GUI look like an empty rectangular window
# ENV QT_X11_NO_MITSHM 1

##RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install build-essential

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libsdl-image1.2
# -dev

#RUN git clone https://github.com/porst17/appchoo.git /usr/src/appchoo/
#RUN cd /usr/src/appchoo && make && cp appchoo /usr/local/bin/ && make clean

COPY . /usr/local/bin/

