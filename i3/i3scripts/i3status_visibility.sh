#!/usr/bin/env bash

path="$(dirname $(realpath $0))/values/i3status_visibility"


mode=$(cat $path)

if [ "$mode" = "" ] ; then
    i=1
elif [ "$mode" = " Hide " ] ; then
    i=2
fi

case $i in
    "1")
        i3-msg bar mode invisible
        echo " Hide " > $path
        ;;
    "2")
        i3-msg bar mode Dock
        echo "" > $path
        ;;
esac
