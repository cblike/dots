# ~/.config/wofi/scripts/network.sh

#!/bin/bash

# Get a list of available Wi-Fi networks
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; theni
	toggle="󰖩  Enable Wi-Fi"
fi

# Use wofi to select a network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | wofi -dmenu -i -p "Wi-Fi Networks")
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$chosen_id"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(wofi -dmenu -p "Password: ")
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$chosen_id"
	fi
fi
