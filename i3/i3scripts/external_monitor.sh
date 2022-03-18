#!/usr/bin/env bash

file="$(dirname $(realpath $0))/values/i3scripts.conf"

primary=$(xrandr | grep \ connected | grep \ primary | cut -d\  -f1)
monitor=$(xrandr | grep \ connected | awk 'NR > 1 {print $1}')

if [ -n "$monitor" ]
then
    # sed -e "s/^display-port=.*/display-port=$monitor/" $file
    cat $file | jq -r '.display.port = $v' --arg v "${monitor}" | sponge $file
    option=$(printf "Left-of Primary|Right-of Primary|Primary|Monitor" | rofi -l 4 -sep '|' -auto-select -mesg "<b>Display Settings</b>" -theme paper -location 1 -dmenu -i -p "")
    case $option in
        "Left-of Primary")
            xrandr --output "$primary" --primary --auto --output "$monitor"
            xrandr --output "$monitor" --mode 1984x1000_60.00 --left-of "$primary"
	    cat $file | jq -r '.display.side = "Left"' | sponge $file
            # sed -r 's/^display-side=.*/display-side=Left/' $file
            ;;
        "Right-of Primary")
            xrandr --output "$monitor" --mode 1984x1000_60.00 --right-of "$primary"
	    cat $file | jq -r '.display.side = "Right"' | sponge $file
	    # sed -i'' -r 's/^display-side=.*/display-side=Right/' $file
	    # echo " Right " > $file
            ;;
        "Primary")
	    xrandr --output "$monitor" --off --output "$primary" --mode 1366x768
	    jq -r '.display.display = "Primary"' $file | sponge $file
            # xrandr --output "$primary" --mode 1366x768
            # xrandr --output "$primary" --primary --auto --output "$monitor" --right-of "$primary" --auto
	    # sed -i'' -r 's/^display=.*/display=Primary/' $file
            # echo "" > $file
            ;;
        "Monitor")
            xrandr --output "$monitor" --mode 1984x1000_60.00
            xrandr --output "$monitor" --mode 1984x1000_60.00 --output "$primary" --off
	    jq -r '.display.display = "Monitor"' $file | sponge $file
	    # sed -e 's/^display=.*/display=Monitor/' $file
	    # echo "" > $file
            ;;
    esac
    # notify-send "$(cat $file | sed -e "s/{//g; s/}//g" | awk 'NR!=2{print $1, $2}')"
    notify-send "$(cat $file | jq -r '.[]')"
else
    # sed -i'' -r 's/^display-side=.*/display-side=/' $file
    # monitor=$(sed -rn 's/display-port=([^\n]+)$/\1/p' $file)
    jq -r '.display.side = null' $file | sponge $file
    monitor=$(jq -r '.display.port' $file)
    # xrandr --output "$primary" --mode 1366x768
    xrandr --output "$monitor" --off --output "$primary" --mode 1366x768
    notify-send "$(cat $file | jq -r '.[]')"
    notify-send "Last Connected: $monitor" -u normal
fi
