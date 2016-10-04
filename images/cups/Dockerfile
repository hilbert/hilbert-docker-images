FROM malex984/dockapp:base
# FROM debian:sid

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# Install cups
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
                    --no-install-recommends \
                    cups cups-pdf whois cups-bsd && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# cups-bsd for lp* tools!

# Disable some cups backend that are unusable within a container
RUN mv /usr/lib/cups/backend/parallel /usr/lib/cups/backend-available/ &&\
    mv /usr/lib/cups/backend/serial /usr/lib/cups/backend-available/ &&\
    mv /usr/lib/cups/backend/usb /usr/lib/cups/backend-available/

COPY etc-cups /etc/cups
COPY etc-pam.d-cups /etc/pam.d/cups

RUN mkdir -p /etc/cups/ssl

#VOLUME /etc/cups/
#VOLUME /var/log/cups
#VOLUME /var/spool/cups
#VOLUME /var/cache/cups


ENV CUPS_USER_ADMIN cups
ENV CUPS_USER_PASSWORD cups

# RUN useradd $CUPS_USER_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_USER_PASSWORD)

COPY start_cups.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_cups.sh 

EXPOSE 631

# CMD ["/usr/local/bin/start_cups.sh"]


