#!/usr/bin/env bash

setxkbmap -option ctrl:swapcaps

xmodmap -e "keysym Control_R control = Escape Control_R" \
        -e "remove mod1 = Alt_R" \
        -e "remove mod4 = Super_R" \
        -e "keysym Alt_R = Super_R" \
        -e "add mod3 = Super_R"

# https://superuser.com/questions/834568/disable-numlock-preserving-mouse-button-key-bindings
# Use numbers even when numlock is off
xmodmap -e "keysym KP_End = KP_1" \
        -e "keysym KP_Down = KP_2" \
        -e "keysym KP_Next = KP_3" \
        -e "keysym KP_Left = KP_4" \
        -e "keysym KP_Begin = KP_5" \
        -e "keysym KP_Right = KP_6" \
        -e "keysym KP_Home = KP_7" \
        -e "keysym KP_Up = KP_8" \
        -e "keysym KP_Prior = KP_9" \
        -e "keysym KP_Insert = KP_0" \
        -e "keysym KP_Delete = KP_Decimal"
