FROM malex984/dockapp:webbase

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

ENV OPERA opera-stable

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN wget -q -O - http://deb.opera.com/archive.key | apt-key add - && \
    echo "deb http://deb.opera.com/${OPERA}/ stable non-free" >> /etc/apt/sources.list.d/opera.list

RUN update.sh && install.sh chromium-codecs-ffmpeg-extra google-chrome-stable chromium-browser ${OPERA} && clean.sh

COPY browser.sh chrome.sh /usr/local/bin/
