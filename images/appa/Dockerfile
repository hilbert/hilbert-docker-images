FROM hilbert/base

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.appa@gmail.com>

# Clean up APT when done.
RUN clean.sh

COPY A.sh /usr/local/bin/

# ENV HOME /home/ur
# RUN chown ur:ur $HOME/bin/A.sh
# CMD /sbin/setuser ur /home/ur/bin/A.sh

