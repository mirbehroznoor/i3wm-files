#!/usr/bin/env bash

path="$(dirname $(realpath $0))/values/layout"

mode=$(cat $path)

if [ "$mode" = "" ] ; then
    i=1
elif [ "$mode" = " DE " ] ; then
    i=2
fi

case $i in
    "1")
        setxkbmap de,us
        echo " DE " > $path
        ;;
    "2")
        setxkbmap us,de
        i3-msg restart
        echo "" > $path
        ;;
esac
