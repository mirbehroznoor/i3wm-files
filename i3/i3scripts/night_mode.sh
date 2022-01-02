#!/bin/bash
# i3 thread: https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/?answer=152#post-id-152
# https://gist.githubusercontent.com/viking/5851049/raw/7ee50450616b1ad3674e321359d2911db6289a1d/i3-shell.sh

path="$(dirname $(realpath $0))/values/night_mode"
# echo "Path: $path"

mode=$(cat $path)
# echo $mode

if [ "$mode" = " Night Mode 3 " ] ; then
    i=0
elif [ "$mode" = " Night Mode 2 " ] ; then
    i=3
elif [ "$mode" = " Night Mode 1 " ] ; then
    i=2
elif [ "$mode" = "" ] ; then
    i=1
fi

for output in $(xrandr --prop | grep \ connected | cut -d\  -f1); do
    case $i in
        "1")
            GAMMA="2:1.2:1 --brightness 0.93"
            xrandr --output $output --gamma $GAMMA
            echo " Night Mode 1 " > $path
            ;;
        "2")
            GAMMA="0.9:0.5:2 --brightness 0.93"
            xrandr --output $output --gamma $GAMMA
            echo " Night Mode 2 " > $path
            ;;
        "3")
            GAMMA="0.60:0.75:0.8 --brightness 0.93"
            xrandr --output $output --gamma $GAMMA
            echo " Night Mode 3 " > $path
            ;;
        "0")
            echo "" > $path
            GAMMA="1:1:1 --brightness 1.0"
            xrandr --output $output --gamma $GAMMA
            ;;
    esac
    exit
    # xrandr --output $output --gamma $GAMMA
done
