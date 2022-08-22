#!/bin/sh
cd -- "$(dirname -- "$0")"

arg_animated=false
arg_delay=0
arg_region=false
arg_focused=
ncmd=0
region=
label=

exit_usage() {
	printf 'Usage:\n' >&2
	printf '  %s %s\n' "$0" '[--animated] [--delay SECONDS] --region' >&2
	printf '  %s %s\n' "$0" '[--animated] [--delay SECONDS] --focused (window | monitor)' >&2
	exit 1
}

# kill any existing recordings
if pkill -INT -x wf-recorder; then
	exit 0
fi

# parse cli arguments
while [ "$#" -gt 0 ]; do
	case "$1" in
		'--animated')
			arg_animated=true
			;;

		'--delay')
			shift || exit_usage
			arg_delay="$1"
			;;

		'--region')
			arg_region=true
			ncmd=$((ncmd + 1))
			;;

		'--focused')
			shift || exit_usage
			arg_focused="$1"
			ncmd=$((ncmd + 1))
			;;

		*)
			exit_usage
			;;
	esac
	shift
done

# exit if there's nothing to do
if [ "$ncmd" -ne 1 ]; then
	exit_usage
fi

# get region of screen
if [ "$arg_region" = true ]; then
	out="$(swaymsg -t get_tree | jq --raw-output -f regions.jq | slurp -f '%x,%y %wx%h:%l\n')"
	region="${out%%:*}"
	label="${out#*:}"
	if [ "$?" -ne 0 ]; then
		printf '%s\n' "couldn't get region!"
		exit 1
	fi
elif [ "$arg_focused" = monitor ]; then
	out="$(swaymsg -t get_outputs | jq --raw-output -f focused_output_region.jq)"
	region="${out%%:*}"
	label="${out#*:}"
	if [ "$?" -ne 0 ]; then
		printf '%s\n' "couldn't get focused monitor!"
		exit 1
	fi
elif [ "$arg_focused" = window ]; then
	out="$(swaymsg -t get_tree | jq --raw-output -f focused_window_region.jq)"
	region="${out%%:*}"
	label="${out#*:}"
	if [ "$?" -ne 0 ]; then
		printf '%s\n' "couldn't get focused window!"
		exit 1
	fi
fi

# prepare output filename
stamp="$(date '+%Y%m%d_%Hh%Mm%Ss')"
outdir="$HOME/Pictures/Screenshots/$(date +%Y/%m)"
mkdir -p "$outdir"
if [ -n "$label" ]; then
	label="$(printf "$label" | tr -c 'a-zA-Z0-9 _.-' '_')"
	stamp="$stamp $label"
fi

# wait
if [ "$arg_delay" -gt 0 ]; then
	sleep "$arg_delay"
fi

# take screenshot
if [ $arg_animated = true ]; then
	exec wf-recorder -c gif -g "$region" -f "$outdir/$(date '+%Y%m%d_%Hh%Mm%Ss').gif"
else
	exec grim -g "$region" "$outdir/$stamp.png"
fi
