#!/bin/sh
set -e
cd -- "$(dirname -- "$0")"
serial="${1?Usage: "$0" SERIAL}"

sleep 1
focus_depth=$(swaymsg -t get_tree | jq -f focus_depth.jq)
while [ $focus_depth -gt 1 ]; do
    swaymsg focus parent
    focus_depth=$(( focus_depth - 1 ))
done

(
    sleep 2;
    sh ~/.config/sway/scripts/scrcpy_resize/scrcpy_resize.sh;
) &
exec scrcpy -s "$serial" --stay-awake --turn-screen-off --shortcut-mod lctrl
