FROM hilbert/base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Update & Install & Clean up APT
# Not: please if possible add all the packages to the following single install command!
RUN update.sh && \
    install.sh \
        --no-install-recommends \
	alsa alsa-tools alsa-utils && \
    clean.sh

# RUN usermod -a -G pulse-access ur
# RUN usermod -a -G pulse ur
# RUN usermod -a -G audio ur

#### TODO: $HOME?
# COPY .asoundrc /root/
# RUN chown ur:ur /home/ur/.asoundrc.save
 
# pulseaudio?
# ADD 01_pulseaudio /etc/my_init.d/01_pulseaudio

COPY soundtest.sh /usr/local/bin/
ADD http://www.alsa-project.org/alsa-info.sh /usr/local/bin/alsa-info.sh
RUN chmod +x /usr/local/bin/alsa-info.sh

# build-essential cmake libglib2.0-dev libasound2-dev ?
# RUN git clone https://github.com/i-rinat/apulse.git /usr/src/apulse/
# RUN mkdir -p /tmp/build && cd /tmp/build && \
#    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release /usr/src/apulse/ && \
#    make && make install

#  cmus paprefs ?

