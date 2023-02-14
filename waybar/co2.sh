#!/bin/sh
source "$XDG_CONFIG_HOME/bash/system"

EXIT_CODE_SHOW=0
EXIT_CODE_HIDE=1

warning() {
    printf '{"text": "ERR", "tooltip": "%s", "class": "warning"}\n' "$@"
}

is_home() {
    is_home_wifi || is_home_ethernet
    return $?
}

is_home_wifi() {
    if [ -z "$MQTT_PRESENCE_WIFI_PROFILE" ]; then
        return 1
    fi

    if ! hash nmcli 2>/dev/null; then
        warning 'for wifi presence detection, install <tt>nmcli</tt>\n\n<i>to disable this message, clear</i> <tt>MQTT_PRESENCE_WIFI_*</tt> <i>in</i> <tt>~/.config/bash/system</tt>'
        exit "$EXIT_CODE_SHOW"
    fi

    nmcli -g GENERAL.STATE c s "$MQTT_PRESENCE_WIFI_PROFILE" | grep -qF activated
    return $?
}

is_home_ethernet() {
    if [ -z "$MQTT_PRESENCE_ETH_IF" ] || [ -z "$MQTT_PRESENCE_ETH_MAC" ]; then
        return 1
    fi

    if ! hash lldpctl 2>/dev/null; then
        warning 'for ethernet presence detection, install <tt>lldpd</tt>\n\n<i>to disable this message, clear</i> <tt>MQTT_PRESENCE_ETH_*</tt> <i>in</i> <tt>~/.config/bash/system</tt>'
        exit "$EXIT_CODE_SHOW"
    fi

    if ! systemctl is-active lldpd; then
        warning 'please start <tt>lldpd</tt>:\n\n\t<tt>sudo systemctl start lldpd</tt><i>to disable this message, clear</i> <tt>MQTT_PRESENCE_ETH_*</tt> <i>in</i> <tt>~/.config/bash/system</tt>'
        exit "$EXIT_CODE_SHOW"
    fi

    sudo lldpctl -f keyvalue | grep -qF "lldp.$MQTT_PRESENCE_ETH_IF.chassis.mac=$MQTT_PRESENCE_ETH_MAC"
    return $?
}

sigterm() {
    warning "received SIGTERM"
    exit "$EXIT_CODE_HIDE"
}
trap sigterm TERM

if is_home; then
    mosquitto_sub -L "$MQTT_URL/$MQTT_TOPIC_CO2" | while read ppm; do
        class=''
        if [ "$ppm" -ge 800 ]; then
            class='critical'
        elif [ "$ppm" -ge 700 ]; then
            class='warning'
        fi
        printf '{"text": "%s", "tooltip": "%s PPM CO2", "class": "%s"}\n' "$ppm" "$ppm" "$class"
    done
fi

exit "$EXIT_CODE_HIDE"
