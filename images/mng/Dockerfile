FROM malex984/dockapp:nodejs

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# install dependencies
RUN update.sh && \
    install.sh --no-install-recommends nginx rsync lftp wakeonlan && \
    clean.sh

# download latest development version and install node.js dependencies
RUN mkdir -p /usr/local && cd /usr/local/ \
    && curl -0L https://github.com/hilbert/hilbert-ui/archive/master.tar.gz | tar -zx \
    && mv hilbert-ui-master hilbert-ui \
    && curl -0L https://github.com/hilbert/hilbert-cli/archive/devel.tar.gz | tar -zx \
    && mv hilbert-cli-devel hilbert-cli \
    && cd /usr/local/hilbert-ui/client && npm install \
    && cd /usr/local/hilbert-ui/server && npm install

# configure nginx
COPY hilbert-ui /etc/nginx/sites-enabled/

# main entry point
COPY run.sh /usr/local/

# tell Docker which port is exposed by the container
# EXPOSE 8080
