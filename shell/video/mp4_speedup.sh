#!/bin/bash
mkdir output
for filename in *.mp4; do
  filename2="output/${filename}"
  ffmpeg -i "$filename" \ 
    -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2[a]" \
    -map "[v]" -map "[a]" -c:v libx264 -c:a aac "$filename2"
done