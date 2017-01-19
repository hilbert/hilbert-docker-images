FROM hilbert/nodejs

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# install dependencies
RUN update.sh && \
    install.sh --no-install-recommends nginx rsync lftp wakeonlan python3-pip && \
    pip3 install --upgrade pip && pip install --upgrade setuptools && \
    pip install dill semantic_version ruamel.yaml argcomplete && \
    clean.sh


# configure nginx
COPY hilbert-ui /etc/nginx/sites-enabled/

# tell Docker which port is exposed by the container
EXPOSE 8080

RUN mkdir -p /usr/local/src

# main entry point
COPY run.sh /usr/local/

# download latest development version and install node.js dependencies
RUN git clone --depth 1 -b 'devel' https://github.com/hilbert/hilbert-ui.git /usr/local/hilbert-ui \
    && cd /usr/local/hilbert-ui/client && npm install && cd /usr/local/hilbert-ui/server && npm install

RUN git clone --depth 1 -b 'feature/hilbert_cli_tools' https://github.com/hilbert/hilbert-cli.git /usr/local/src/cli \
    && cd /usr/local/src/cli && python3 ./setup.py install 

