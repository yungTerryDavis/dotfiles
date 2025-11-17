#!/usr/bin/bash
# start swww
WALLPAPERS_DIR=~/Pictures/Wallpapers/2k
WALLPAPER=$(find $"WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER"
