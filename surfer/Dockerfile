FROM malex984/dockapp:gui

MAINTAINER Christian Stussak <stussak@mfo.de>

RUN wget http://imaginary.org/sites/default/files/surfer-1.2.4.x86_64.deb && dpkg -i surfer-1.2.4.x86_64.deb && rm surfer-1.2.4.x86_64.deb
RUN touch /root/.javafx_eula_accepted

COPY .fxsurfer /root/
