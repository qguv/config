#!/bin/sh
set -o pipefail

function _startswith() { case "$1" in "$2"*) true;; *) false;; esac; }

if [ "$1" = clean ]; then
    find "$XDG_CONFIG_HOME/PulseEffects" -type l | while read f; do
        dest="$(find "$f" -prune -printf "%l\n")"
        printf '%s\n=>  %s\n\n' "$f" "$dest"
        if _startswith "$dest" "$XDG_CONFIG_HOME/PulseEffects/community"; then
            echo rm "$f"
        fi
    done

else
    find "$XDG_CONFIG_HOME/PulseEffects/community" -type f -path '*.json' | while read f; do
        ln -fs "$f" "$XDG_CONFIG_HOME/PulseEffects/"
        echo "installed ${f##*/}"
    done
fi
