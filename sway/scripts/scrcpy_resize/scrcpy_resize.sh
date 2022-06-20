#!/bin/sh
set -e
cd -- "$(dirname -- "$0")"

swaymsg -t get_tree | jq --exit-status --raw-output --from-file gen_resize_cmd.jq | while read cmd; do
    #echo "$cmd" # DEBUG
    #continue # DEBUG
    swaymsg "$cmd"
done
