#!/bin/sh

set -e

echo "Testing ALSA..."

# 1. step: important mixer settings - these are hardware dependent and (probably) not really necessary
echo "Unmuting and settinv volumes... "
amixer sset Master 100% unmute cap
amixer sset PCM 100% unmute cap
amixer sset Capture 99% unmute cap

echo "Detailed info (for the case of troubles):"
aplay -vv -l
aplay -vv -L

#aplay -D plughw:0,0 -vv /usr/share/alsa/??/Rear_Center.wav

#echo "Starting alsamixer: please unmute devices (marked with <MM>) with 'm'-key and press ESC...."
#sleep 3
#alsamixer --view=all

#aplay -vv /tmp/Rear_Center.wav
echo "Speaker Test for 2 loops:"
speaker-test -D plughw:0,0 -l2 -c2 -twav

echo "Recording voice for 4 sec..."
arecord -f cd -D plughw:0,1 -d4 -vv /tmp/mic.wav

echo "And outputting it now: "
aplay -vv -D plughw:0,0 /tmp/mic.wav

rm /tmp/mic.wav

echo "That's it! Hope everything worked out fine!"
sleep 2
#  Please press ENTER to exit..."
# read



TODO: https://wiki.archlinux.org/index.php/PulseAudio/Examples#PulseAudio_as_a_minimal_unintrusive_dumb_pipe_to_ALSA 
