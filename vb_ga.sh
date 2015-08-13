#!/bin/bash

SELFNAME=$(basename "$0")

#SELFDIR=`dirname "$0"`
#cd "$SELFDIR"
#SELFDIR=`pwd`

VER="$@"
LAST="4.3.28"
if [ -z "$VER" ]; then
  if [ -e "/sys/module/vboxvideo/version" ]; then 
    VER=$(cat /sys/module/vboxvideo/version)
  fi
fi

if [ -z "$VER" ]; then
  VER="$LAST"
fi

### http://stackoverflow.com/a/4024263
# find the later version of VB GA
VER=$(echo "$VER\n$LAST" | sort -V | tail -n1)

if [ -e "/sys/module/vboxvideo/version" ]; then 
  [ $(cat /sys/module/vboxvideo/version) = "$VER" ] && exit 0
fi


TMP=/tmp/
# $(mktemp -d -t /tmp)

echo "Installing VB GA: '$VER' (tmp: '$TMP')..." 

echo "Installing requirements..."
DEBIAN_FRONTEND=noninteractive apt-get install -qqy --force-yes build-essential dkms "linux-headers-`uname -r | sed 's@-generic@@'`" "linux-headers-`uname -r`"

cd $TMP

ISO="VBoxGuestAdditions_$VER.iso"
RUN="VBoxLinuxAdditions.run"

wget -q -nc -c -O "$TMP/$ISO" "http://download.virtualbox.org/virtualbox/$VER/$ISO"

echo "Extracting .RUN from $(ls -l $TMP/$ISO)..."

7z x "$TMP/$ISO" -y -bd -ir"!$RUN"  -w"$TMP" -o"$TMP"  || exit 1

echo "Running $(ls -l $TMP/$RUN)..."

sh "$TMP/$RUN" 2>&1 || true
cat /var/log/vboxadd-install.log

DEBIAN_FRONTEND=noninteractive apt-get install -fy

rm -f "$TMP/$RUN" "$TMP/$ISO" || true

# /etc/init.d/vboxadd setup

/etc/init.d/vboxadd-x11 stop
/etc/init.d/vboxadd-service stop
/etc/init.d/vboxadd stop
rmmod vboxvideo
rmmod vboxsf
rmmod vboxguest

/etc/init.d/vboxadd start
/etc/init.d/vboxadd-service start
/etc/init.d/vboxadd-x11 start
modprobe vboxguest
modprobe vboxsf
modprobe vboxvideo


echo "Setting up VB GA: '$VER' is done! Currently loaded vboxvideo version: `cat /sys/module/vboxvideo/version`"

exit 0
