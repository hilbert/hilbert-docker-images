# close button overlay
# run with
# sudo docker run --rm -i -e DISPLAY -v /tmp:/tmp --ipc=host repo/image:tag /usr/local/share/qclosebutton/x_64x64.png /your/app
FROM phusion/baseimage:0.9.16

MAINTAINER Christian Stussak <stussak@mfo.de>

# RUN apt-get update
# RUN apt-get install -qqy 
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install libqt5gui5 libqt5widgets5

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install curl g++ make qt5-default && \
	curl -SL https://github.com/IMAGINARY/qclosebutton/archive/master.tar.gz | tar -xz && \
    cd qclosebutton-master && \
    qmake && \
    make && \
    cp qclosebutton /usr/local/bin/ && \
    mkdir -p /usr/local/share/qclosebutton/ && \
    cp *.png /usr/local/share/qclosebutton/ && \
    rm -rf /qclosebutton-master && \
    apt-get purge -qqy --auto-remove curl g++ make qt5-default

ENTRYPOINT [ "/usr/local/bin/qclosebutton" ]
