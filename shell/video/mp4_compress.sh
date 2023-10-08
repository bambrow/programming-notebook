#!/bin/bash
mkdir compressed
for filename in *.mp4; do
  filename2="compressed/${filename}"
  # ffmpeg -i "$filename" -vcodec h264 -b:v 1000k -acodec mp2 "$filename2"
  # ffmpeg -i "$filename" -vcodec h264 -b:v 1000k -acodec mp3 "$filename2"
  ffmpeg -i "$filename" -vcodec h264 -acodec aac "$filename2"
done