#!/bin/sh
cd -- "$(dirname -- "$0")"

waiting=""
_trap() {
    waiting=""
}
trap _trap USR1

reap() {
    swaymsg -t get_tree | jq -f useless_splits.jq | while read id; do
        swaymsg "[con_id=$id]" split none
    done
}

defer_reap() {
    if [ -n "$waiting" ]; then
        kill "$waiting"
    fi

    (
        # if no action taken in 2 seconds
        sleep 2 &&

        # then clear out the "waiting" variable
        kill -s USR1 $$ &&

        # and reap windows
        reap
    ) &
    waiting=$!
}

while true; do
    cmd="$(
            swaymsg -t subscribe '["binding", "workspace", "shutdown", "window"]' |
            jq -rf subscribe.jq
    )"
    case "$cmd" in
        split|layout)
            defer_reap
            ;;
        reload|exit)
            exit
            ;;
        *)
            if [ -n "$waiting" ]; then
                defer_reap
            else
                reap
            fi
            ;;
    esac
done
