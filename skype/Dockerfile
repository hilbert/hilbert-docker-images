FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Setup multiarch because Skype is 32bit only
# Make sure the repository information is up to date

RUN dpkg --add-architecture i386 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade


RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y alsa:i386 alsa-tools:i386

## adding custom build of apulse for 32 bit ubuntu:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y libglib2.0-dev:i386 libasound2-dev:i386
COPY apulse/libpulsecommon-5.0.so apulse/libpulse-simple.so apulse/libpulse-simple.so.0 apulse/libpulse.so apulse/libpulse.so.0 /usr/lib/i386-linux-gnu/apulse/

# For video:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y v4l-utils:i386

# Install Skype (http://download.skype.com/linux/...)
ADD http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb /usr/src/skype.deb

RUN dpkg -i /usr/src/skype.deb || true && apt-get install -fy
RUN rm -f /usr/src/skype.deb

# Our own starter via apulse: 
COPY skype.sh /usr/local/bin/

### TODO: for later!
##COPY skype-4.3.0.37.tar.bz2 /usr/src/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
