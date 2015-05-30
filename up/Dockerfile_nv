FROM $IMG

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

COPY ilkh.sh /usr/local/bin/

ENV NVIDIA_VERSION="$VER"

RUN curl "http://us.download.nvidia.com/XFree86/Linux-x86_64/$VER/NVIDIA-Linux-x86_64-$VER.run" \
    -o /tmp/nv && chmod +x /tmp/nv && /tmp/nv -s -N --no-kernel-module
    
RUN mv /tmp/nv "/usr/src/NVIDIA-Linux-x86_64-$VER.run"

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
