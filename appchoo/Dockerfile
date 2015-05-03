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


# TODO: Find corresponding tools or their analogs...
### ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/BM.tar.bz2 /usr/src/BM.tar.bz2

# fbsuite seems to be rather outdated, and unusable on 64 bit ubuntu14.04 :(
### ADD http://downloads.sourceforge.net/project/fbsuite/fbsuite/0.9.7.6/xfbsuite-0.9.7.6.tgz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ffbsuite%2F&ts=1429031264&use_mirror=switch /usr/src/xfbsuite-0.9.7.6.tgz
# | tar -xz && cd xfbsuite-0.9.7.6 && install.sh

###ADD http://xdialog.free.fr/Xdialog-2.3.1.tar.bz2 /usr/src/Xdialog-2.3.1.tar.bz2



# ADD http://www.ozone3d.net/gputest/dl/GpuTest_Linux_x64_0.7.0.zip /usr/src/GpuTest_Linux_x64_0.7.0.zip
# Forbidden??

## It seems that he following require some command line tools 
ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/GPU_Test_Info_Linux64.tar.gz

###ADD appchoo qclosebutton /usr/local/bin

# RUN apt-get purge -qqy --auto-remove 
# curl make gcc linux-headers libgcc 

## ENTRYPOINT [ "/usr/local/bin/appchoo" ]


#ADD NVIDIA-Linux-x86_64-340.76.run /usr/src/NVIDIA-Linux-x86_64-340.76.run
#RUN chmod +x usr/src/NVIDIA-Linux-x86_64-340.76.run 
#RUN /usr/src/NVIDIA-Linux-x86_64-340.76.run -s -N --no-kernel-module
#RUN rm /usr/src/NVIDIA-Linux-x86_64-340.76.run


# ENV VBOX_VERSION    4.3.26
## ADD VirtualBox-4.3.26-98988-Linux_amd64.run /tmp/
# ADD http://dlc-cdn.sun.com/virtualbox/4.3.26/VirtualBox-4.3.26-98988-Linux_amd64.run /usr/src/
ADD VBoxLinuxAdditions.run /tmp/
RUN chmod +x /tmp/VBoxLinuxAdditions.run && /tmp/VBoxLinuxAdditions.run && rm /tmp/VBoxLinuxAdditions.run || rm /tmp/VBoxLinuxAdditions.run


