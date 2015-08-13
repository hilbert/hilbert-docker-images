FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

COPY A.sh /usr/local/bin/

# ENV HOME /home/ur
# RUN chown ur:ur $HOME/bin/A.sh
# CMD /sbin/setuser ur /home/ur/bin/A.sh

# Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
