FROM hilbert/webbase
#< Base image with the necessary libraries for web-browsers:

#! Person responsible for this image:
ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.chrome@gmail.com>

#! Default value for environment variable (used below)
ENV OPERA opera-stable

#! Get repository keys and add corresponding repository to package sources 
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

#! Another repository
RUN wget -q -O - http://deb.opera.com/archive.key | apt-key add - && \
    echo "deb http://deb.opera.com/${OPERA}/ stable non-free" >> /etc/apt/sources.list.d/opera.list

#! Update repository caches and install some SW packages. Do not forget to do clean-up
RUN update.sh && install.sh chromium-codecs-ffmpeg-extra google-chrome-stable chromium-browser ${OPERA} && clean.sh

#! Add necessary resources: wrapper scripts
COPY browser.sh chrome.sh /usr/local/bin/
