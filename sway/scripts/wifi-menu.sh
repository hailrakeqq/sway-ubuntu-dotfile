#!/bin/bash

# список мереж
ssid=$(nmcli -t -f SSID dev wifi list | sort -u | wofi --dmenu --prompt "WiFi")

[ -z "$ssid" ] && exit

# якщо вже підключено — просто перепідключимось
nmcli dev wifi connect "$ssid"

notify-send "WiFi" "Connected to $ssid"
