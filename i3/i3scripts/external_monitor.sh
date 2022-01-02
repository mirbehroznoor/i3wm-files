#!/usr/bin/env bash

file="$(dirname $(realpath $0))/values/screen"

option=$(printf "Left-of Primary|Right-of Primary|Primary|Monitor" | rofi -l 4 -sep '|' -auto-select -mesg "<b>Display Settings</b>" -theme paper -location 1 -dmenu -i -p "")

primary=$(xrandr | grep \ connected | grep \ primary | cut -d\  -f1)
monitor=$(xrandr | grep \ connected | awk 'NR > 1 {print $1}')


case $option in
    "Left-of Primary")
	xrandr --output "$primary" --primary --auto --output "$monitor"
        xrandr --output "$monitor" --mode 1984x1000_60.00 --left-of "$primary"
        echo " Left " > $file
	;;
    "Right-of Primary")
	xrandr --output "$monitor" --mode 1984x1000_60.00 --right-of "$primary"
        echo " Right " > $file
	;;
    "Primary")
	xrandr --output "$primary" --mode 1366x768
	xrandr --output "$primary" --primary --auto --output "$monitor" --right-of "$primary" --auto
        echo "" > $file
        ;;
    "Monitor")
	xrandr --output "$monitor" --mode 1984x1000_60.00
	xrandr --output "$monitor" --mode 1984x1000_60.00 --output "$primary" --off
	echo "" > $file
	;;
esac
