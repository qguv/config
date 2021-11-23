#!/usr/bin/env sh

SPEED="$(cat /sys/class/net/enp57s0f1/speed)"
UNIT_SHORT="M"
UNIT_LONG="Mb/s"
case "$SPEED" in
    -1)
        exit 1
        ;;
    1000)
        SPEED="1"
        UNIT_SHORT="G"
        UNIT_LONG="Gb/s"
        break
        ;;
esac

printf "%d%s\nLink speed: %d %s\nethspeed" "$SPEED" "$UNIT_SHORT" "$SPEED" "$UNIT_LONG"
