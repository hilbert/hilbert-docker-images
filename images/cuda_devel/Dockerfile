# Taken from https://gitlab.com/nvidia/cuda/blob/ubuntu14.04/7.5/devel/Dockerfile
ARG IMAGE_VERSION=someversion
FROM hilbert/cuda_runtime:${IMAGE_VERSION}

MAINTAINER Oleksandr Motsak <malex984+hilbert.cuda.devel@gmail.com>

RUN update.sh \
&& install.sh \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-misc-headers-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-license-$CUDA_PKG_VERSION \
        cuda-nvrtc-dev-$CUDA_PKG_VERSION \
        cuda-cusolver-dev-$CUDA_PKG_VERSION \
        cuda-cublas-dev-$CUDA_PKG_VERSION \
        cuda-cufft-dev-$CUDA_PKG_VERSION \
        cuda-curand-dev-$CUDA_PKG_VERSION \
        cuda-cusparse-dev-$CUDA_PKG_VERSION \
        cuda-npp-dev-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-driver-dev-$CUDA_PKG_VERSION \
        cuda-samples-$CUDA_PKG_VERSION \
&& cd /tmp && apt-get download gpu-deployment-kit \
&& mkdir /tmp/gpu-deployment-kit && cd /tmp/gpu-deployment-kit \
&& dpkg -x /tmp/gpu-deployment-kit_*.deb . \
&& mv usr/include/nvidia/gdk/* /usr/local/cuda/include \
&& mv usr/src/gdk/nvml/lib/* /usr/local/cuda/lib64/stubs \
&& rm -rf /var/lib/apt/lists/* /tmp/gpu-deployment-kit*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs:${LIBRARY_PATH}

##############################################################################
ARG GIT_NOT_CLEAN_CHECK
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE=someday
ARG VCS_REF=HEAD
ARG VCS_URL="https://github.com/hilbert/hilbert-docker-images"

ARG DOCKERFILE="/images/cuda_devel/Dockerfile"
LABEL org.label-schema.description="Base for OpenGL+CUDA development" \
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
