FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install alsa alsa-tools 
# pulseaudio

# RUN usermod -a -G pulse-access ur
# RUN usermod -a -G pulse ur
# RUN usermod -a -G audio ur

# ADD asoundrc /home/ur/.asoundrc.save
# RUN chown ur:ur /home/ur/.asoundrc.save
 
# ADD 01_pulseaudio /etc/my_init.d/01_pulseaudio

COPY soundtest.sh /usr/local/bin/

# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends cmus
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install --no-install-recommends paprefs

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
