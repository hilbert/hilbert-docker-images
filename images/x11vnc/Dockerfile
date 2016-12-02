FROM hilbert/xeyes

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
         --no-install-recommends \
                x11vnc && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VOLUME /tmp/.X11-unix/
COPY x11vnc.sh /usr/local/bin/

# ENV HOME=/root
# RUN mkdir "$HOME/.vnc"
# Setup a password
# RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# x11vnc -usepw -forever

EXPOSE 5900-5910

