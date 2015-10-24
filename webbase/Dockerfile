FROM malex984/dockapp:test

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && \
    install.sh gconf-service libgconf-2-4 libnspr4 libnss3 libpango1.0-0 libxss1 fonts-liberation libappindicator1 xdg-utils \
       libindicator7 libgtk2.0-0 libasound2 libxtst6 libexif12 \
       mtdev-tools libmtdev-dev libmtdev1 \
       dbus-x11 dbus libdbus-glib-1-2 libdbusmenu-glib4 \
       xinput && \
    clean.sh
