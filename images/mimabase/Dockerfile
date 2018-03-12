ARG IMAGE_VERSION=someversion
FROM hilbert/gui:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.mimabase@gmail.com>

# DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver ? --recv-keys ? && \
# ppa:mozillateam/firefox-stable ppa:mozillateam/firefox-next 

##RUN DEBIAN_FRONTEND=noninteractive echo|add-apt-repository ppa:ubuntu-mozilla-daily/ppa && \
##    update.sh && install.sh flashplugin-nonfree firefox-trunk && clean.sh

### https://cloud.imaginary.org/index.php/s/SzXG9TdMyzPlvXX

# && apt-add-repository --yes ppa:webupd8team/java \
# && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
### oracle-java8-installer=8u151-1~webupd8~0 oracle-java8-set-default

#! Get repository keys and add corresponding repository to package sources 
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
 && apt-add-repository --yes ppa:ubuntu-mozilla-security/ppa \
 && update.sh \
 && install.sh chromium-codecs-ffmpeg-extra firefox nginx \
               gconf2 gconf-service libnotify4 libappindicator1 libxtst6 libnss3 \
 && wget -q "https://cloud.imaginary.org/index.php/s/JRd3Ob5yz86SUka/download" -O /tmp/kiosk-browser.deb \
 && dpkg -i /tmp/kiosk-browser.deb \
 && wget -q "https://launchpad.net/~ubuntu-mozilla-security/+archive/ubuntu/ppa/+build/13537990/+files/firefox_56.0+build6-0ubuntu0.14.04.2_amd64.deb"  -O /tmp/firefox.deb \
 && dpkg -i /tmp/firefox.deb \
 && install.sh -fy \
 && clean.sh && mkdir -p /opt
########### https://www.slimjet.com/chrome/download-chrome.php?file=lnx%2Fchrome64_51.0.2704.84.deb

## google-chrome-stable 
# && wget -q "https://sjmulder.nl/dl/chrome/chrome64_51.0.2704.84.deb" -O /tmp/chrome.deb \
# && dpkg -i /tmp/chrome.deb \


#########################################
# configure nginx
RUN mkdir -p /var/www/html \
 && ln -s /opt /var/www/html/ \
 && rm -f /etc/nginx/sites-available/default

COPY nginx.default /etc/nginx/sites-available/default
COPY nginx.sh /usr/local/

###RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY .show_close_button /root/

#########################################
#RUN mkdir -p /root/.mozilla
#COPY .mozilla /root/.mozilla/

#ADD https://cloud.imaginary.org/index.php/s/e65pmGhOyDEnxTh/download /tmp/ff.tar.bz2
ADD https://cloud.imaginary.org/index.php/s/B0G13fyRSStI26y/download /tmp/ff.tar.gz
RUN tar xzvf /tmp/ff.tar.gz -C /root/

COPY firefox.sh browser.sh kiosk.sh launch.sh run.sh /opt/

#########################################
#RUN mkdir -p /opt/applauncher2 /opt/various
#COPY applauncher2 /opt/applauncher2/
RUN git clone --depth 1 -b 'master' https://github.com/IMAGINARY/applauncher2.git /opt/applauncher2


###
#ADD https://cloud.imaginary.org/index.php/s/fIR5p8KJx8Q0pMq/download /opt/frozenlight/frozenlight-1.2.2.jar
#COPY FroZenLight.sh dune-ash.sh menu.sh psd.sh qi.sh soe.js.dev.sh the-future-of-glaciers.sh IceCaps-MPT2017.sh MatchTheNet.sh /opt/

# "?cfg=geometrie-dynamik" "?cfg=planeten-erde"


# configure services for baseimage-docker's init system
#RUN echo "#!/bin/sh\nnginx" > /etc/rc.local
#RUN mkdir -p /etc/service/hilbert_ui_api \
#    && echo "#!/bin/sh\ncd /usr/local/hilbert-ui/server/app\nexec node main.js" > /etc/service/hilbert_ui_api/run \
#    && chmod +x  /etc/service/hilbert_ui_api/run


#RUN mkdir -p /opt/touchviewer-1.1 /opt/the-future-of-glaciers /opt/MatchTheNet /opt/SphereOfEarth_JS_dev /opt/melting-ice-caps /opt/powergrid-dynamics-simulation
#COPY touchviewer-1.1 /opt/touchviewer-1.1/
#COPY the-future-of-glaciers /opt/the-future-of-glaciers/
#COPY MatchTheNet /opt/MatchTheNet/
#COPY SphereOfEarth_JS_dev /opt/SphereOfEarth_JS_dev/
#COPY melting-ice-caps /opt/melting-ice-caps/
#COPY powergrid-dynamics-simulation /opt/powergrid-dynamics-simulation/


# && gpg --keyserver subkeys.pgp.net --recv-keys 8B48AD6246925553 && gpg -a --export 8B48AD6246925553 | apt-key add - \
# && gpg --keyserver subkeys.pgp.net --recv-keys 7638D0442B90D010 && gpg -a --export 7638D0442B90D010 | apt-key add - \
# && gpg --keyserver subkeys.pgp.net --recv-keys EF0F382A1A7B6500 && gpg -a --export EF0F382A1A7B6500 | apt-key add - \

# && gpg --keyserver pgpkeys.mit.edu --recv-keys 8B48AD6246925553 && gpg -a --export 8B48AD6246925553 | apt-key add - \
# && gpg --keyserver pgpkeys.mit.edu --recv-keys 7638D0442B90D010 && gpg -a --export 7638D0442B90D010 | apt-key add - \
# && gpg --keyserver pgpkeys.mit.edu --recv-keys EF0F382A1A7B6500 && gpg -a --export EF0F382A1A7B6500 | apt-key add - \
# && apt-add-repository --yes "deb http://ftp.de.debian.org/debian jessie-backports main" \
# && apt-add-repository --yes "deb http://ftp.de.debian.org/debian stretch main" \

# && apt-add-repository --yes "deb http://home.mathematik.uni-freiburg.de/dune debian/" \

#RUN add-apt-repository --yes universe \
# && update.sh \
# && install.sh libsdl-ttf2.0-0 libsdl1.2debian libsdl-image1.2 libsdl-image1.2 libopenmpi1.6 libopenmpi1.6 openmpi-bin \
#       ttf-dejavu fonts-baekmuk libgmp10 libalberta2 libumfpack5.6.2 libsuperlu3 libgmpxx4ldbl libmetis5 rsh-client openssh-client \
# && clean.sh


# && install.sh -fy --force-yes
# && install.sh --force-yes dune-ash \

## COPY dune-ash.tar.bz2 /tmp/
## RUN tar xjvf /tmp/dune-ash.tar.bz2 -C /opt/

ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/mimabase/Dockerfile"
LABEL org.label-schema.description="Shared Base for MIMA images" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0"     

ONBUILD LABEL org.label-schema.build-date="" \
      org.label-schema.name="" \
      org.label-schema.description="" \
      org.label-schema.vendor="" \
      org.label-schema.url="" \
      org.label-schema.vcs-ref="" \
      org.label-schema.vcs-url="" \
      org.label-schema.version="" \
      org.label-schema.schema-version="" \
      com.microscaling.license="" \
      com.microscaling.docker.dockerfile="" \
      IMAGE_VERSION="" \
      GIT_NOT_CLEAN_CHECK=""

