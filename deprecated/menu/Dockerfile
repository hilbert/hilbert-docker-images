FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

COPY ./menu.sh /usr/local/bin/

#ENV HOME /home/ur
#RUN chown ur:ur $HOME/bin/menu.sh
# USER ur
# WORKDIR $HOME
# VOLUME $HOME
# USER ur
# ENTRYPOINT ["$HOME/bin/menu.sh"]
# CMD ""

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
