FROM malex984/dockapp:base

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

ADD ./docker-latest /usr/local/bin/docker
COPY ./docker-compose /usr/local/bin/

# RUN chmod +x /usr/local/bin/docker /usr/local/bin/docker-compose
# RUN ln -s $HOME/bin/docker-latest $HOME/bin/docker
## ENV DOCKER_CERT_PATH=

# nsenter does not work from inside a container :(
# ADD ./baseimage-docker-nsenter ./docker-bash /usr/local/bin/

# RUN groupadd -f -g 998 docker
# RUN usermod -a -G docker ur
# USER ur
# ENV HOME /home/ur
# VOLUME $HOME
# WORKDIR $HOME

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
