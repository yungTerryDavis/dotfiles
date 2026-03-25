#!/usr/bin/bash
# start awww
WALLPAPERS_DIR=~/Pictures/Wallpapers/2k
WALLPAPER=$(find $"WALLPAPERS_DIR" -type f | shuf -n 1)
awww img "$WALLPAPER"
