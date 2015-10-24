FROM malex984/dockapp:webbase

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN update.sh && install.sh google-chrome-stable && clean.sh

#ADD https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /tmp/google-chrome-stable_current_amd64.deb
#RUN dpkg -i /tmp/google-chrome-stable_current_amd64.deb && install.sh -fy

COPY browser.sh chrome.sh /usr/local/bin/
