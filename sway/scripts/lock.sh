#!/bin/bash
IMAGE=/tmp/screen.png
TEXT=/tmp/locktext.png
FONT=Liberation-Mono

MONITOR_INFO=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | [.name, .current_mode.width] | join("@")')
MONITOR_NAME="${MONITOR_INFO%%@*}"
MONITOR_WIDTH="${MONITOR_INFO##*@}"

grim -o "$MONITOR_NAME" "$IMAGE"

convert "$IMAGE" -scale 25% -blur 0x2 -scale 400% -fill black -colorize 50% "$IMAGE"
[[ -f $1 ]] && convert "$IMAGE" $1 -gravity center -composite -matte "$IMAGE"

[ -f $TEXT ] || {
    convert -size "${MONITOR_WIDTH}x100" xc:black -font "$FONT" -pointsize 40 -fill white -gravity center -annotate +0+0 'Type password to unlock' $TEXT;
}

convert "$IMAGE" "$TEXT" -gravity center -geometry +0+200 -composite "$IMAGE"
swaylock -s fill -i "$IMAGE" --font "$FONT" --show-keyboard-layout
