#!/bin/bash
for filename in *.m4a; do
  filename2="${filename%.*}.mp3"
  ffmpeg -i "$filename" "$filename2"
done
