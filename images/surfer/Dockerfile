FROM hilbert/gui

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.surfer@gmail.com>

#ADD https://imaginary.org/sites/default/files/surfer-1.2.4.x86_64.deb /tmp/surfer.deb
ADD https://imaginary.org/sites/default/files/surfer-1.5.0.x86_64.deb /tmp/surfer.deb

RUN update.sh \
 && dpkg -i /tmp/surfer.deb \
 && install.sh -fy \
 && clean.sh

RUN touch /root/.javafx_eula_accepted
COPY .fxsurfer /root/
