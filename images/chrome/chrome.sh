#! /bin/bash

B="${GOOGLE_CHROME:-/opt/google/chrome/google-chrome}"

exec $B \
--enable-pinch \
--flag-switches-begin --disable-threaded-scrolling \
--enable-apps-show-on-first-paint --enable-embedded-extension-options \
--enable-experimental-canvas-features --enable-gpu-rasterization \
--javascript-harmony --enable-pinch --enable-settings-window \
--enable-touch-editing --enable-webgl-draft-extensions \
--enable-experimental-extension-apis --ignore-gpu-blacklist \
--disable-overlay-scrollbar --show-fps-counter --ash-touch-hud \
--touch-events=enabled \
--flag-switches-end "$@"
