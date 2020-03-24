#!/bin/sh

swaymsg -t get_tree | jq -r '.. | objects | select((.type == "workspace") and ( .. | objects | .focused == true)) | .representation' > /tmp/repr
