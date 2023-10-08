#!/bin/bash
for folder in */; do
  echo "Working on ${folder}..."
  cd ${folder}
  git pull origin master
  cd ..
done