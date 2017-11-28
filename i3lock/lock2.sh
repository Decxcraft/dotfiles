#!/usr/bin/env bash

icon="$HOME/Pictures/lockIcon/lock.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
playerctl pause
i3lock -u -i "$tmpbg"
