FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install alsa alsa-tools
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install alsa-utils

# pulseaudio

# RUN usermod -a -G pulse-access ur
# RUN usermod -a -G pulse ur
# RUN usermod -a -G audio ur

# ADD asoundrc /home/ur/.asoundrc.save
# RUN chown ur:ur /home/ur/.asoundrc.save
 
# ADD 01_pulseaudio /etc/my_init.d/01_pulseaudio

COPY soundtest.sh /usr/local/bin/
ADD http://www.alsa-project.org/alsa-info.sh /usr/local/bin/alsa-info.sh

# RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y build-essential cmake libglib2.0-dev libasound2-dev
# RUN git clone https://github.com/i-rinat/apulse.git /usr/src/apulse/
# RUN mkdir -p /tmp/build && cd /tmp/build && \
#    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release /usr/src/apulse/ && \
#    make && make install


# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends cmus
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends paprefs

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
