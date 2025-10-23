#!/bin/bash

# Did they provide a file?
if [[ -z $1 ]]; then
    echo "Usage: $0 <file>"
    exit 1
fi
WALLPAPER="$1"

# Determine monitor order
mapfile -t monitors < <(hyprctl monitors | grep -E '(Monitor |at )' | paste - - | awk '{print $2, $7}' | cut -d'x' -f1 | sort -nk2 | awk '{print $1}')

# Split the image for each monitor
crop_perc=$((100/${#monitors[@]}))
magick "$1" -crop $crop_perc%x100% ~/.cache/wallpaper/wall.png

# Assign the images per monitor
for i in "${!monitors[@]}"; do
  swww img -o "${monitors[$i]}" ~/.cache/wallpaper/wall-"$i".png --transition-type left --transition-fps 60; sleep 1.6;
done

