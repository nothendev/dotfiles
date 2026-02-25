#!/usr/bin/env bash

path=$(date +/home/ilya/Pictures/%Y%m%d_%Hh%Mm%Ss_)
if [[ $1 == "full" ]]; then
  cmd=$(/usr/bin/grim -g '0,0 3840x1920' ~/Pictures/.tmp.png && magick ~/Pictures/.tmp.png -crop $(slurp -f '%wx%h+%x+%y') $path)
  path=$path"crop.png"
  fs=" full screen"
else
  cmd=$(/usr/bin/grim -g "$(slurp)")
  path=$path"grim.png"
fi

echo $cmd

out=$($cmd && notify-send "Saved$fs screenshot!" "Path: $path" -t 5000 -A default=Copy)

if [[ "$out" == "default" ]]; then
  notify-send "Copied path to clipboard!" -t 1000
  wl-copy $path
fi
