#!/usr/bin/env bash

time=$(date | awk '{print $4}' | cut -d : -f 1)

if [ $time -ge 17 -a $time -le 05 ]
then
    xsetroot -solid "royalblue2"
else
    xsetroot -solid "cornsilk"
fi

# exec_always --no-startup-id feh --bg-center ~/Pictures/wall_gork.jpg
# exec_always --no-startup-id xsetroot -solid "deep sky blue"
# exec_always --no-startup-id xsetroot -solid "lemon chiffon"
# exec_always --no-startup-id xsetroot -solid "royalblue2"
# exec_always --no-startup-id xsetroot -solid "black"
# exec_always --no-startup-id xsetroot -solid "maroon2"
# exec_always --no-startup-id xsetroot -solid "lavender blush"
# exec_always --no-startup-id xsetroot -solid "cornsilk"
# exec_always --no-startup-id xsetroot -solid "deep pink"
# exec_always --no-startup-id xsetroot -solid "#002244"
# exec_always --no-startup-id xsetroot -solid "#7a378b"
