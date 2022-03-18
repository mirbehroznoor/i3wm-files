#!/usr/bin/bash

# xrandr --newmode "2200x1200_60.00"  221.50  2200 2352 2584 2968  1200 1203 1213 1245 -hsync +vsync
# xrandr --addmode HDMI1 "2200x1200_60.00"
# xrandr --addmode LVDS1 "2200x1200_60.00"

xrandr --newmode "2104x1000_60.00"  174.75  2104 2240 2456 2808  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode HDMI1 "2104x1000_60.00"
xrandr --addmode LVDS1 "2104x1000_60.00"

xrandr --newmode "2000x1000_60.00"  166.25  2000 2128 2336 2672  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode HDMI1 "2000x1000_60.00"
xrandr --addmode LVDS1 "2000x1000_60.00"

xrandr --newmode "1984x1000_60.00"  164.25  1984 2104 2312 2640  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode HDMI1 "1984x1000_60.00"
xrandr --addmode LVDS1 "1984x1000_60.00"

xrandr --newmode "1704x1200_60.00"  171.25  1704 1824 2000 2296  1200 1203 1213 1245 -hsync +vsync
xrandr --addmode HDMI1 "1704x1200_60.00"
xrandr --addmode LVDS1 "1704x1200_60.00"

xrandr --newmode "1680x900_60.00"  124.50  1680 1776 1952 2224  900 903 913 934 -hsync +vsync
xrandr --addmode HDMI1 "1680x900_60.00"
xrandr --addmode LVDS1 "1680x900_60.00"

xrandr --newmode "1680x1000_60.00"  139.25  1680 1784 1960 2240  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode HDMI1 "1680x1000_60.00"
xrandr --addmode LVDS1 "1680x1000_60.00"

xrandr --newmode "1680x768_60.00"  104.75  1680 1768 1936 2192  768 771 781 798 -hsync +vsync
xrandr --addmode HDMI1 "1680x768_60.00"
xrandr --addmode LVDS1 "1680x768_60.00"

file="$(dirname $(realpath $0))/values/i3scripts.conf"
primary=$(xrandr | grep \ connected | grep \ primary | cut -d\  -f1)
monitor=$(xrandr | grep \ connected | awk 'NR > 1 {print $1}')

filesize=$(cat $file | wc -l)
# notify-send "$(cat $file)"

if [ -e $file ]
then
    if [ -s $file ] # -s file isnot zero size
    then
	# notify-send "Good" -u critical -t 2000
        # if [ "$filesize" -ge 0 ]
        # then
            # truncate -s 0 "$file"
	# echo "$(cat <<EOM
	# { "display" : {
	# "display": null,
	# "side": null,
	# "port": null
	# } }
	# EOM
	# )" > $file
        # printf "{"Display": {"display": null,"port":null, "side": null}"}"" >> $file
        # cat $file
        # fi
	notify-send "$(cat $file | jq -r '.[]')"
    else
	echo '$(cat<<EOM
	{ "display" : {
	"display": null,
	"side": null,
	"port": null}}
	EOM
	)' > $file
        # printf "display-port=\ndisplay-side=\ndisplay=\n" >> $file
        # cat $file
    fi
else
    notify-send "Display Config file or folder missing!" -u critical
fi

if [ -n "$monitor" ]
then
    # sed -i'' -r "s/^display-port=.*/display-port=$monitor/" $file
    cat $file | jq -r '.display.port = $v' --arg v "${monitor}" | sponge $file
    # Turn off primary display if monitor connected
    # xrandr --output "$monitor" --mode 1984x1000_60.00
    # xrandr --output "$monitor" --mode 1984x1000_60.00 --output "$primary" --off
    # Donot turn off primary display if monitor connected
    xrandr --output "$primary" --primary --auto --output "$monitor"
    xrandr --output "$monitor" --mode 1984x1000_60.00 --left-of "$primary"

else
    # monitor=$(sed -rn "s/display-port=([^\n]+)$/\1/p" $file)
    # xrandr --output "$primary" --mode 1366x768
    monitor=$(jq -r '.display.port' $file)
    xrandr --output "$monitor" --off --output "$primary" --mode 1366x768
    # echo "$primary"
fi

# xrandr --output "$primary" --primary --auto --output "$monitor"
# xrandr --output "$monitor" --mode 1984x1000_60.00 --left-of "$primary"
