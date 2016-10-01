#!/bin/sh

SELFNAME=`basename "$0" .sh`
## set -e

GL="$@"
GL="${GL:-/tmp/OGL.tgz}"

HOME=${HOME:-/root}

if [ -e "$GL" ]; then  
  echo "Customizing using '$GL':"
  # --skip-old-files
  ls -la "$GL"
  tar xzvf "$GL" --overwrite -C /tmp/ 'root/.asoundrc'
  mv /tmp/root/.asoundrc $HOME/
fi

if [ ! -z "${ALSA_CARD}" ]; then 

CARD="${ALSA_CARD}"

cat <<EOF > $HOME/.asoundrc
pcm.!default {
    type hw
    card $CARD
}
ctl.!default {
    type hw
    card $CARD
}
EOF
## fi
fi

cat $HOME/.asoundrc

echo "Testing ALSA..."

# 1. step: important mixer settings - these are hardware dependent and (probably) not really necessary
echo "Unmuting and settinv volumes... "
#amixer sset Master "100%" unmute cap
#amixer sset PCM "100%" unmute cap
amixer sset Capture "99%" unmute cap

echo "Detailed info (for the case of troubles):"
aplay -vv -l
aplay -vv -L

#aplay -D plughw:0,0 -vv /usr/share/alsa/??/Rear_Center.wav

#echo "Starting alsamixer: please unmute devices (marked with <MM>) with 'm'-key and press ESC...."
#sleep 3
#alsamixer --view=all

#aplay -vv /tmp/Rear_Center.wav
echo "Speaker Test for 2 loops:"

## -D plughw:0,0 
speaker-test -l2 -c2 -twav

echo "Recording voice for 4 sec..."

## -D plughw:0,1
arecord -f cd  -d4 -vv /tmp/mic.wav

echo "And outputting it now: "
## -D plughw:0,0
aplay -vv  /tmp/mic.wav

rm /tmp/mic.wav

echo "That's it! Hope everything worked out fine!"
sleep 2
#  Please press ENTER to exit..."
# read



### TODO: https://wiki.archlinux.org/index.php/PulseAudio/Examples#PulseAudio_as_a_minimal_unintrusive_dumb_pipe_to_ALSA 
