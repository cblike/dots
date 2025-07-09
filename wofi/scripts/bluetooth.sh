#!/bin/bash

# Power on bluetooth
bluetoothctl power on

# Get paired and available devices
devices=$(bluetoothctl devices | awk '{print $3, $4, $5}')
paired_devices=$(bluetoothctl paired-devices | awk '{print $3, $4, $5}')

# Combine and show in wofi
chosen=$(echo -e "$paired_devices\n$devices" | uniq | wofi --dmenu -p "Bluetooth")
mac=$(bluetoothctl devices | grep "$chosen" | awk '{print $2}')

# Connect to the chosen device
bluetoothctl connect "$mac"
