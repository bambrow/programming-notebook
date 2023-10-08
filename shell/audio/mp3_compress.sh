#!/bin/bash
mkdir compressed
for filename in *.mp3; do
  filename2="compressed/${filename}"
  lame -b 32 "$filename" "$filename2"
done