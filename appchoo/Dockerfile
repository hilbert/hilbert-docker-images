# appchoo application chooser
# run image with
# echo -e "/path/to/image1.jpg output_this_string_if_image1_has_been_clicked\n/path/to/image2.png output_this_string_if_image2_has_been_clicked\n" | \
#     sudo docker run --rm -i -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix repo/image

# FROM alpine:3.1
FROM malex984/dockapp:gui
# phusion/baseimage:0.9.16

MAINTAINER Christian Stussak <stussak@mfo.de>

# RUN apt-get -y update

# make gcc linux-headers libgcc 

RUN apt-get install -q -y build-essential
#  linux-headers-generic

# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install
# curl
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install 

ADD https://github.com/IMAGINARY/xfullscreen/archive/master.tar.gz /usr/src/xfullscreen.tar.gz

# curl g++ make ???

# sdl sdl_image libpng jpeg
# sdl-dev sdl_image-dev musl-dev
ADD https://github.com/porst17/appchoo/archive/master.tar.gz /usr/src/appchoo.tar.gz
# | tar -xz && cd appchoo-master && make && cp appchoo /usr/local/bin/ && rm -rf /appchoo-master


# libqt5gui5 libqt5widgets5
# qt5-default
ADD https://github.com/IMAGINARY/qclosebutton/archive/master.tar.gz /usr/src/qclosebutton.tar.gz
# | tar -xz && cd qclosebutton-master && qmake && make && cp qclosebutton /usr/local/bin/ && rm -rf qclosebutton-master

# RUN apt-get purge -qqy --auto-remove 
# curl make gcc linux-headers libgcc 

## ENTRYPOINT [ "/usr/local/bin/appchoo" ]
