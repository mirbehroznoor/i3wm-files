#!/usr/bin/bash

img=/tmp/i3lock.png
Blur="5x4"

scrot $img
convert $img -scale 10% -scale 1000% -blur $Blur $img
i3lock -u -i $img
rm $img
