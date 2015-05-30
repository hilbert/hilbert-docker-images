FROM $IMG

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get  -q -y install p7zip-full wget

COPY ilkh.sh /usr/local/bin/

ENV VBOX_VERSION="$VER"

RUN cd /tmp/ && \
    wget -q "http://download.virtualbox.org/virtualbox/$VER/VBoxGuestAdditions_$VER.iso" && \
    7z x "VBoxGuestAdditions_$VER.iso" -y -bd -ir'!VBoxLinuxAdditions.run'

RUN (sh /tmp/VBoxLinuxAdditions.run; cat /var/log/vboxadd-install.log )
RUN mkdir -p /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/ && \
    chmod go+rx /usr/lib/xorg/modules/drivers/ /usr/lib/x86_64-linux-gnu/dri/

RUN test -e /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so || \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxOGL.so \
            /usr/lib/x86_64-linux-gnu/dri/vboxvideo_dri.so
RUN test -e /usr/lib/xorg/modules/drivers/vboxvideo_drv.so || \
    ln -s /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/vboxvideo_drv_115.so \
            /usr/lib/xorg/modules/drivers/vboxvideo_drv.so

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -qqy --auto-remove p7zip-full && \
    rm -f  /tmp/VBoxGuestAdditions_$VER.iso && mv /tmp/VBoxLinuxAdditions.run /usr/src

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#### https://gist.github.com/mattes/2d0ffd027cb16571895c
#  mkdir x86 && cd x86 && tar xvjf ../VBoxGuestAdditions-x86.tar.bz2 && cd .. && \
#  mkdir amd64 && cd amd64 && tar xvjf ../VBoxGuestAdditions-amd64.tar.bz2 && cd .. && \
#  cd amd64/src/vboxguest-$VBOX_VERSION && KERN_DIR=/linux-kernel/ make && cd ../../.. && \
#  cp amd64/src/vboxguest-$VBOX_VERSION/*.ko $ROOTFS/lib/modules/$KERNEL_VERSION-tinycore64 && \
#  mkdir -p $ROOTFS/sbin && cp x86/lib/VBoxGuestAdditions/mount.vboxsf $ROOTFS/sbin/

