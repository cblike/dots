#!/bin/bash

# Create a directory for the backup
echo "Creating backup directory at ~/hyprland-backup..."
mkdir -p ~/repos/dots/

# Copy Hyprland configuration
echo "Backing up Hyprland configuration..."
cp -r ~/.config/hypr/ ~/repos/dots/

# Copy Waybar configuration
echo "Backing up Waybar configuration..."
cp -r ~/.config/waybar/ ~/repos/dots/

# Copy Wofi configuration
echo "Backing up Wofi configuration..."
cp -r ~/.config/wofi/ ~/repos/dots/

# Copy .bashrc
cp ~/.bashrc ~/repos/dots/

echo "Backup of configuration files completed in ~/hyprland-backup"#!/bin/bash


