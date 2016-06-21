FROM phusion/baseimage:0.9.16

MAINTAINER Christian Stussak <stussak@mfo.de>

# install dependencies
RUN DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
    && DEBIAN_FRONTEND=noninteractive sudo apt-get install -y -q nodejs nginx git \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# download latest development version and install node.js dependencies
RUN mkdir -p /usr/local \
    && cd /usr/local/ && curl -0L https://github.com/IMAGINARY/dockapp_dashboard/archive/master.tar.gz | tar -zx \
    && mv dockapp_dashboard-master dockapp_dashboard \
    && cd /usr/local/dockapp_dashboard/ && npm install \
    && cd /usr/local/dockapp_dashboard/server && npm install

# configure nginx
RUN echo '\
server {\n\
       listen       8080;\n\
       server_name  localhost;\n\
\n\
       location / {\n\
           root   /usr/local/dockapp_dashboard/public;\n\
           index index.html index.htm;\n\
       }\n\
\n\
       location /api/ {\n\
               proxy_pass http://127.0.0.1:3000/;\n\
               proxy_redirect default;\n\
               proxy_http_version 1.1;\n\
               proxy_set_header Upgrade $http_upgrade;\n\
               proxy_set_header Connection 'upgrade';\n\
               proxy_set_header Host $host;\n\
               proxy_cache_bypass $http_upgrade;\n\
       }\n\
\n\
       error_page   500 502 503 504  /50x.html;\n\
       location = /50x.html {\n\
           root   html;\n\
       }\n\
}\n'\
>> /etc/nginx/sites-enabled/dockapp-dashboard

# tell Docker which port is exposed by the container
EXPOSE 8080

# configure services for baseimage-docker's init system
RUN echo "#!/bin/sh\nnginx" > /etc/rc.local
RUN mkdir -p /etc/service/dockapp_dashboard_api \
    && echo "#!/bin/sh\ncd /usr/local/dockapp_dashboard/server/app\nexec node main.js" > /etc/service/dockapp_dashboard_api/run \
    && chmod +x  /etc/service/dockapp_dashboard_api/run

# use baseimage-docker's init system as entry point
ENTRYPOINT ["/sbin/my_init"]
