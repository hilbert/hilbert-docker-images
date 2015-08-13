# appchoo application chooser
# run image with
# echo -e "/path/to/image1.jpg output_this_string_if_image1_has_been_clicked\n/path/to/image2.png output_this_string_if_image2_has_been_clicked\n" | \
#     sudo docker run --rm -i -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix repo/image

# FROM alpine:3.1
FROM malex984/dockapp:xeyes
#x11vb
# phusion/baseimage:0.9.16

MAINTAINER Christian Stussak <stussak@mfo.de>

# RUN apt-get -y update

## RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install dkms build-essential
## RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install linux-headers-generic 


RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libgles1-mesa libgles2-mesa libegl1-mesa-drivers libgl1-mesa-dri mesa-vdpau-drivers
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install nux-tools mesa-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install glmark2

# ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz

# curl g++ make ???

# musl-dev??
#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libsdl-image1.2-dev
#ADD https://github.com/porst17/appchoo/archive/master.tar.gz /usr/src/appchoo.tar.gz
#RUN tar -xzvf /usr/src/appchoo.tar.gz -C /tmp && cd /usr/src/appchoo-master && make && cp appchoo /usr/local/bin/ && cd / && rm -rf /usr/src/appchoo-master

#RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install qt4-default qt4-qmake 
#ADD https://github.com/IMAGINARY/qclosebutton/archive/master.tar.gz /usr/src/qclosebutton.tar.gz
#RUN tar -xzvf /usr/src/qclosebutton.tar.gz -C /tmp && cd /usr/src/qclosebutton-master && qmake && make && cp qclosebutton /usr/local/bin/ && cd / && rm -rf /usr/src/qclosebutton-master

###ADD http://xdialog.free.fr/Xdialog-2.3.1.tar.bz2 /usr/src/Xdialog-2.3.1.tar.bz2

###ADD appchoo qclosebutton /usr/local/bin
# fbsuite seems to be rather outdated, and unusable on 64 bit ubuntu14.04 :(

# TODO: Find corresponding tools or their analogs...
### ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/BM.tar.bz2 /usr/src/BM.tar.bz2


# Forbidden: http://www.ozone3d.net/gputest/dl/GpuTest_Linux_x64_0.7.0.zip :(((

## It seems that he following require some command line tools 
ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/GPU_Test_Info_Linux64.tar.gz


# RUN apt-get purge -qqy --auto-remove 

## ENTRYPOINT [ "/usr/local/bin/appchoo" ]
