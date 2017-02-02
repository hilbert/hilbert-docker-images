FROM hilbert/dd

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.main@gmail.com>

RUN update.sh && install.sh xauth && clean.sh

COPY main.sh menu.sh run.sh runback.sh sv.sh A.sh generate_ogl.sh settings /usr/local/bin/

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh

#EXPOSE 80
## 631
