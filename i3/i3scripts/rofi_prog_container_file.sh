#!/usr/bin/bash

option=$(printf "1-FileExplorer 2-Containers 3-Programs" | rofi -l 3 -sep ' ' -auto-select -mesg "<b>Programs i3-Containers File-Explorer</b>" -theme paper -location 1 -dmenu -i -p "")

case $option in
    "1-FileExplorer")
        # pcmanfm
	nautilus
    ;;
    "2-Containers")
        rofi -modi window -show window -width 35 -lines 25 -separator-style none -columns 3 -disable-history -hide-scrollbar -theme Adapta-Nokto
        ;;
    "3-Programs")
        rofi -modi drun -show drun -line-margin 0 -line-padding 2 -separator-style none -columns 10 -disable-history -hide-scrollbar -font 'Noto Sans 8' -theme big_border
        ;;
esac
