#!/bin/bash
for i in */ ; do
  DIR_NAME=$i
  JOB_NAME=$(basename "$0")
  :
  if [ -f "./$DIR_NAME/$JOB_NAME" ]; then
    read -p "Do $i? [yn]" answer
    if [[ $answer = y ]] ; then
      echo
      echo in $i \"$JOB_NAME\" script
      echo
      cd "$DIR_NAME"
      "./$JOB_NAME"
      cd ../
    fi
  fi
done
