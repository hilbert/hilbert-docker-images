ARG IMAGE_VERSION=someversion
FROM hilbert/base:${IMAGE_VERSION}
#####~~debian:sid~~

MAINTAINER Oleksandr Motsak <malex984+hilbert.cups@gmail.com>

# Install cups
RUN update.sh && install.sh cups cups-pdf whois cups-bsd && clean.sh
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



ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/cups/Dockerfile"
LABEL org.label-schema.description="testing CUPS server" \
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

