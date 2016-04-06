FROM docker/compose:1.6.2

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN apk update && apk add bash docker 
# && apk cache clean

COPY luncher.sh finishall.sh topswitch.sh /usr/local/bin/

ENTRYPOINT ["luncher.sh"]

