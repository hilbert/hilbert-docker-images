FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# https://github.com/nodesource/distributions

#RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
#ADD https://deb.nodesource.com/setup_4.x /tmp/setup_4.sh
#RUN chmod +x /tmp/setup_4.sh && bash /tmp/setup_4.sh

## curl --silent --location https://deb.nodesource.com/setup_4.x | sudo -E bash -
## wget -qO- https://deb.nodesource.com/setup_4.x | bash -

RUN update.sh && \
    DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    install.sh --no-install-recommends nodejs && \
    clean.sh

#RUN npm install electron-prebuilt -g 
## && npm install asar -g && \
##    npm install yargs -g

# ONBUILD COPY package.json index.html main.js /usr/src/kiosk/
# CMD [ "npm", "start" ]
# CMD [ "launch.sh", "/usr/src/kiosk/run.sh" ] ## ??
