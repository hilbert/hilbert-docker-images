FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Setup multiarch because Skype is 32bit only
# Make sure the repository information is up to date

# ??? #RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \

RUN dpkg --add-architecture i386 && \
    DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install \
                    -q -y \
                    alsa:i386 alsa-tools:i386 \
		    libglib2.0-dev:i386 libasound2-dev:i386 \
		    v4l-utils:i386

## adding custom build of apulse for 32 bit ubuntu:
COPY apulse/libpulsecommon-5.0.so apulse/libpulse-simple.so apulse/libpulse-simple.so.0 apulse/libpulse.so apulse/libpulse.so.0 /usr/lib/i386-linux-gnu/apulse/

# Install Skype (http://download.skype.com/linux/...)
ADD http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb /usr/src/skype.deb

RUN dpkg -i /usr/src/skype.deb || true && \
    DEBIAN_FRONTEND=noninteractive apt-get install -fy && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -f /usr/src/skype.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Our own starter via apulse: 
COPY skype.sh /usr/local/bin/

### TODO: for later!
##COPY skype-4.3.0.37.tar.bz2 /usr/src/

