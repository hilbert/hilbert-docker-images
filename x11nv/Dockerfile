FROM malex984/dockapp:x11

MAINTAINER Oleksandr Motsak <malex984@googlemail.com>

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
# RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install build-essential 

#### $(uname -r)  ### UPDATE: same headers as the host kernel ! :(
##RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install ...  dkms 
#  linux-headers-3.13.0-48
## linux-headers-$(uname -r)

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ADD http://www.mathematik.uni-kl.de/~motsak/files/BM/GPU_Test_Info_Linux64.tar.gz /usr/src/GPU_Test_Info_Linux64.tar.gz

# TODO: services?
# CMD Xorg


ADD NVIDIA-Linux-x86_64-340.76.run /usr/src/NVIDIA-Linux-x86_64-340.76.run
RUN chmod +x usr/src/NVIDIA-Linux-x86_64-340.76.run 
RUN /usr/src/NVIDIA-Linux-x86_64-340.76.run -s -N --no-kernel-module
RUN rm /usr/src/NVIDIA-Linux-x86_64-340.76.run

## HUGE BLOB!!!
#ADD cuda_6.5.14_linux_64.run /usr/src/
