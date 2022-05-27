#!/bin/sh

export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots/$(date +%Y/%m)"
usage='./shot.sh (region | monitor) [animate]'

if killall -HUP wf-recorder 2>/dev/null; then
	exit 0
fi

if [ "${2:-}" = animate ]; then
	case "${1:-}" in
	region)
		flag="-g"
		arg="$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)"
		;;
	monitor)
		flag="-o"
		arg="$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"
		;;
	*)
		echo "$usage" 1>&2
		exit 1
		;;
	esac

	f="screencast_$(date +%11s)"
	vid="/tmp/$f.mp4"
	gif="$GRIM_DEFAULT_DIR/$f.gif"

	mkdir -p "$GRIM_DEFAULT_DIR"
	wf-recorder "$flag" "$arg" -f "$vid"

	ffmpeg -i "$vid" -vf 'fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse' -loop 0 "$gif"

	rm "$vid"
	echo "$gif"
else
	case "${1:-}" in
	region)
		mkdir -p "$GRIM_DEFAULT_DIR"
		exec grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)"
		;;
	monitor)
		mkdir -p "$GRIM_DEFAULT_DIR"
		exec grim -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"
		;;
	*)
		echo "$usage" 1>&2
		exit 1
		;;
	esac
fi
