#!/bin/bash

spad=$(i3-msg -t get_tree | jq '.nodes[] | .nodes[] | .nodes[] | select(.name=="__i3_scratch") | .floating_nodes[] | .nodes[] | .window_properties ["class"]' | rofi -mesg "<b> ScratchPad Containers </b>" -dmenu -theme-str 'inputbar { enabled: false;}' -width 35 -font 'ubuntu 15')

i3-msg scratchpad show [class="$spad"]
