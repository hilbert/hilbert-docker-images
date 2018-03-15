FROM ubuntu:16.04

MAINTAINER Oleksandr Motsak <malex984+hilbert.duneash@gmail.com>

COPY clean.sh install.sh update.sh upgrade.sh /usr/local/bin/

RUN update.sh \
 && install.sh python3-software-properties software-properties-common \
 && add-apt-repository --yes universe \
 && add-apt-repository --yes ppa:graphics-drivers/ppa \
 && apt-add-repository --yes "deb http://home.mathematik.uni-freiburg.de/dune debian/" \
 && update.sh \
 && install.sh \
       libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxi6 libxxf86vm1 libxcomposite1 libxdamage1 libxfixes3 libxmu6 libxt6 libxv1 \
       libglew1.10 libglu1 freeglut3 libvdpau-va-gl1 \
       libglapi-mesa libglu1-mesa libgles1-mesa libgles2-mesa libgl1-mesa-dri libgl1-mesa-glx libegl1-mesa-drivers mesa-vdpau-drivers mesa-utils \
       mtdev-tools libmtdev-dev libmtdev1 \
       libsdl-ttf2.0-0 libsdl1.2debian libsdl-image1.2 libsdl-image1.2 \
       ttf-dejavu fonts-baekmuk \
 && install.sh --force-yes dune-ash \
 && install.sh -fy --force-yes \
 && clean.sh
#libopenmpi1.6 libalberta2 libumfpack5.6.2 libsuperlu3 libgmp10 libgmpxx4ldbl libmetis5 
#rsh-client openssh-client openmpi-bin 

# dist-upgrade ?
ENV UID=1000
ENV GROUPS=1000
ENV USER=kiosk


### RUN groupadd -r ur && useradd -r -g ur ur
RUN groupadd -f -g $GROUPS $USER \
 && adduser --disabled-login --uid $UID --gid $GROUPS --gecos 'non-root-user' $USER \
 && usermod -a -G sudo $USER \
 && mkdir -p /etc/sudoers.d \
 && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
 && chmod 0440 /etc/sudoers.d/$USER

USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

COPY dune-ash.sh /opt/
COPY hb_dummy.sh hb.sh /usr/local/bin/

## for nvidia-docker:
ENV CUDA_VERSION 7.5.18
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"
ENV CUDA_PKG_VERSION 7-5=7.5-18


ARG IMAGE_VERSION=someversion
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/duneash/Dockerfile"
LABEL org.label-schema.description="DuneAsh on Ubuntu 16.04" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.version="${IMAGE_VERSION}" \
      com.microscaling.docker.dockerfile="${DOCKERFILE}" \
      IMAGE_VERSION="${IMAGE_VERSION}" \
      GIT_NOT_CLEAN_CHECK="${GIT_NOT_CLEAN_CHECK}" \
      org.label-schema.name="Hilbert" \
      org.label-schema.vendor="IMAGINARY gGmbH" \
      org.label-schema.url="https://hilbert.github.io" \
      org.label-schema.schema-version="1.0" \
      com.microscaling.license="Apache-2.0"     

ONBUILD LABEL org.label-schema.build-date="" \
      org.label-schema.name="" \
      org.label-schema.description="" \
      org.label-schema.vendor="" \
      org.label-schema.url="" \
      org.label-schema.vcs-ref="" \
      org.label-schema.vcs-url="" \
      org.label-schema.version="" \
      org.label-schema.schema-version="" \
      com.microscaling.license="" \
      com.microscaling.docker.dockerfile="" \
      IMAGE_VERSION="" \
      GIT_NOT_CLEAN_CHECK=""

