FROM malex984/dockapp:dd

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN update.sh && install.sh --no-install-recommends \
	                   xauth && \
    clean.sh

COPY main.sh menu.sh run.sh sv.sh A.sh generate_ogl.sh settings /usr/local/bin/

# VOLUME ...
# CMD /usr/local/bin/main.sh
# /sbin/setuser ?? ___.sh

#EXPOSE 5900-5910
#EXPOSE 80
#EXPOSE 6556
#EXPOSE 5000
## 631
