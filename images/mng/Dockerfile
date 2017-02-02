FROM hilbert/nodejs

ARG IMAGE_VERSION=latest
LABEL IMAGE_VERSION=${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.mng@gmail.com>

# install dependencies
RUN update.sh && \
    install.sh nginx rsync lftp wakeonlan python3-pip && \
    pip3 install --upgrade pip && pip install --upgrade setuptools && \
    pip install dill semantic_version ruamel.yaml argcomplete && \
    clean.sh && \
    rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default /root/.ssh

# tell Docker which port is exposed by the container
# EXPOSE 8000

RUN mkdir -p /usr/local/src

# download latest development version and install node.js dependencies
RUN git clone --depth 1 -b 'devel' https://github.com/hilbert/hilbert-ui.git /usr/local/hilbert-ui \
    && cd /usr/local/hilbert-ui/client && npm install && cd /usr/local/hilbert-ui/server && npm install

RUN git clone --depth 1 -b 'feature/hilbert_cli_tools' https://github.com/hilbert/hilbert-cli.git /usr/local/src/cli \
    && cd /usr/local/src/cli && python3 ./setup.py install 

# Dummy script checker  (instead of full Haskel Suite)
COPY shellcheck /usr/local/bin/
COPY config.json /usr/local/hilbert-ui/server/
COPY scripts /usr/local/hilbert-ui/server/scripts/

# configure nginx
COPY hilbert-ui /etc/nginx/sites-enabled/

# configure services for baseimage-docker's init system
#RUN echo "#!/bin/sh\nnginx" > /etc/rc.local

#RUN mkdir -p /etc/service/hilbert_ui_api \
#    && echo "#!/bin/sh\ncd /usr/local/hilbert-ui/server/app\nexec node main.js" > /etc/service/hilbert_ui_api/run \
#    && chmod +x  /etc/service/hilbert_ui_api/run

# main entry point
COPY nginx.sh run.sh uiserver.sh /usr/local/

ENV HOME /root
