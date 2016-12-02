FROM hilbert/webbase

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver ? --recv-keys ? && \
# ppa:mozillateam/firefox-stable ppa:mozillateam/firefox-next 

##RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-daily/ppa && \
##    update.sh && install.sh flashplugin-nonfree firefox-trunk && clean.sh
RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-security/ppa && \
    update.sh && install.sh flashplugin-nonfree firefox && clean.sh

RUN update.sh && install.sh iceweasel && clean.sh

COPY firefox.sh browser.sh /usr/local/bin/


