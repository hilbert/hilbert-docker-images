FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Update & Install & Clean up APT
# Not: please if possible add all the packages to the following single install command!
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends \
                    cups-bsd alsa alsa-tools alsa-utils && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# RUN usermod -a -G pulse-access ur
# RUN usermod -a -G pulse ur
# RUN usermod -a -G audio ur

# ADD asoundrc /home/ur/.asoundrc.save
# RUN chown ur:ur /home/ur/.asoundrc.save
 
# pulseaudio?
# ADD 01_pulseaudio /etc/my_init.d/01_pulseaudio

ADD http://www.alsa-project.org/alsa-info.sh /usr/local/bin/alsa-info.sh
COPY soundtest.sh /usr/local/bin/

# RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y build-essential cmake libglib2.0-dev libasound2-dev
# RUN git clone https://github.com/i-rinat/apulse.git /usr/src/apulse/
# RUN mkdir -p /tmp/build && cd /tmp/build && \
#    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release /usr/src/apulse/ && \
#    make && make install


# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends cmus
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends paprefs

