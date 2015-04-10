FROM alpine:3.1
MAINTAINER Christian Stussak <stussak@mfo.de>

RUN apk update
RUN apk add mesa-dri-swrast xorg-server-xephyr xkeyboard-config xkbcomp

ADD startXephyr.sh /

ENTRYPOINT [ "/startXephyr.sh" ]
