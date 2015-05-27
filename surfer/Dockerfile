FROM malex984/dockapp:gui

MAINTAINER Christian Stussak <stussak@mfo.de>

ADD http://imaginary.org/sites/default/files/surfer-1.2.4.x86_64.deb /tmp/surfer-1.2.4.x86_64.deb
RUN dpkg -i /tmp/surfer-1.2.4.x86_64.deb && rm /tmp/surfer-1.2.4.x86_64.deb

RUN touch /root/.javafx_eula_accepted
COPY .fxsurfer /root/
