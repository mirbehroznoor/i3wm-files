#!/usr/bin/env bash

path="$(dirname $(realpath $0))/values/layout"
mode=$(cat $path)
# mode=$(sed -rn 's/keyboard-layout=([^\n]+)$/\1/p' $path)

if [ "$mode" = "" ] ; then
    i=1
elif [ "$mode" = " DE " ] ; then
    i=2
fi

case $i in
    "1")
        setxkbmap de,us
	# sed -ir "s/^keyboard-layout=.*/keyboard-layout= DE /" $path
        echo " DE " > $path
        ;;
    "2")
        setxkbmap us,de
        i3-msg restart
	# sed -ir "s/^keyboard-layout=.*/keyboard-layout=/" $path
        echo "" > $path
        ;;
esac
