#!/bin/sh

OUTDIR="$HOME/Pictures/Screenshots"

arg_extension=

exit_usage() {
	printf 'Usage:\n' >&2
	printf '  %s %s\n' "$0" '[--extension EXT]' >&2
	exit 1
}

# parse cli arguments
while [ "$#" -gt 0 ]; do
	case "$1" in
		'--extension')
			shift || exit_usage
			arg_extension="$1"
			;;

		*)
			exit_usage
			;;
	esac
	shift
done

# get latest directory
year="$(ls "$OUTDIR" | sort -n | tail -n 1)"
month="$(ls "$OUTDIR/$year" | sort -n | tail -n 1)"
dir="$OUTDIR/$year/$month"

if [ -n "$arg_extension" ]; then
    filename="$dir/$(ls -t "$dir" | grep '\.'"$arg_extension"'$' | head -n 1)"
else
    filename="$dir/$(ls -t "$dir" | head -n 1)"
fi

exec dbus-send --session --dest=org.freedesktop.FileManager1 --type=method_call /org/freedesktop/FileManager1 org.freedesktop.FileManager1.ShowItems array:string:"file://$filename" string:""
