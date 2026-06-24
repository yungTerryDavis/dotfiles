#!/bin/bash

WG_IF="sg"
WG_IF_ICON="🇸🇬"

# Add commands to sudoers file
vpn_status_cmd() {
    sudo /sbin/wg show "$WG_IF" transfer
}

vpn_on_cmd() {
    sudo wg-quick up "$WG_IF"
}

vpn_off_cmd() {
    sudo wg-quick down "$WG_IF"
}

icon_connected=" "
icon_disconnected=" "
icon_connecting="󱆣 "


# human_bytes() {
#     awk -v bytes="$1" '
#     BEGIN {
#         split("B KiB MiB GiB TiB", u)
#         i=1
#         while (bytes >= 1024 && i < 5) {
#             bytes /= 1024
#             i++
#         }
#         printf "%.2f %s", bytes, u[i]
#     }'
# }

check_connection() {
    # Read wg transfer values
    local STATUS="$1"

    RX=$(awk '{rx+=$2} END {print rx+0}' <<< "$STATUS")
    TX=$(awk '{tx+=$3} END {print tx+0}' <<< "$STATUS")

    if [[ -z "$RX" || -z "$TX" ]]; then
        echo "Error, couldn't parse transfer values" >&2
        echo 2

    # If 0, not connected
    elif awk -v rx="$RX" -v tx="$TX" 'BEGIN { exit !(rx == 0 && tx == 0) }'; then
        echo "No data transmitted yet (RX=$RX, TX=$TX)" >&2
        echo 1

    else
        # RX_H=$(human_bytes "$RX")
        # TX_H=$(human_bytes "$TX")
        echo "Connected (RX=$RX, TX=$TX)" >&2
        echo 0

    fi
}

listen() {
    local PREV_STATUS=""
    while true; do
        STATUS=$(vpn_status_cmd)
        if [[ "$STATUS" != "$PREV" ]]; then
            CONNECTED=$(check_connection "$STATUS")

            if (( $CONNECTED == 0 )); then
                RX=$(awk '{rx+=$2} END {printf "%.2f", (rx+0)/1024/1024}' <<< "$STATUS")
                TX=$(awk '{tx+=$3} END {printf "%.2f", (tx+0)/1024/1024}' <<< "$STATUS")
                printf '{"text":"%s","tooltip":"WireGuard: %s\rReceived: %s MiB\rSent: %s MiB","class":"up"}\n' \
                        "$icon_connected" "$WG_IF_ICON" "$RX" "$TX"
            else
                printf '{"text":"%s","tooltip":"WireGuard disconnected","class":"down"}\n' \
                        "$icon_disconnected"
            fi
            
            PREV="$STATUS"
        elif [[ -z "$STATUS" ]]; then
            printf '{"text":"%s","tooltip":"WireGuard disconnected","class":"down"}\n' \
                            "$icon_disconnected"
        fi
        sleep 2
    done
}

toggle_connection() {
    if ip link show "$WG_IF" >/dev/null 2>&1; then
        vpn_off_cmd
    else
        vpn_on_cmd
    fi
}

case $1 in
toggle)
  toggle_connection
  ;;
listen)
  listen
  ;;
*)
  printf "Please supply an option\nvpn <option>\nOptions can be either 'toggle' or 'listen'\n"
  ;;
esac