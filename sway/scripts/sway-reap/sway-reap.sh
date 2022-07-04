#!/bin/sh
cd -- "$(dirname -- "$0")"

waiting=""
_trap() {
    waiting=""
}
trap _trap USR1

simplify() {
    swaymsg -t get_tree | jq -f useless_splits.jq | while read id; do
        swaymsg "[con_id=$id]" split none
    done
    echo "simplify"
}

timer_cancel() {
    if [ -n "$waiting" ]; then
        printf 'cancel %d' "$waiting"
        kill "$waiting"
        printf ' ok\n'
    fi
}

timer_start() {
    (
        # if no action taken in 2 seconds
        sleep 2 &&

        # then clear out the "waiting" variable
        kill -s USR1 "$$" &&

        # and simplify tree
        printf '  simplify %d' "$$" &&
        simplify &&
        printf ' ok\n'
    ) &
    waiting=$!
    printf 'in 2s (%d)... ' "$waiting"
}

while true; do
    cmd="$(
            swaymsg -t subscribe '["binding", "workspace", "shutdown", "window"]' |
            jq -rf subscribe.jq
    )"
    printf '> %s\n' "$cmd"
    case "$cmd" in
        title)
            ;;
        split|layout)
            timer_cancel
            timer_start
            ;;
        reload|exit|"")
            timer_cancel
            exit
            ;;
        *)
            if [ -n "$waiting" ]; then
                timer_cancel
                timer_start
            else
                printf 'simplify (via "%s")' "$cmd" &&
                simplify &&
                printf ' ok\n'
            fi
            ;;
    esac
done
