#!/bin/bash
for filename in *.mp4; do
  filename2="${filename%.*}.mp3"
  ffmpeg -i "$filename" -vn \
    -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 \
    "$filename2"
done