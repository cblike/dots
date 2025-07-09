#!/bin/bash

# Prompt for GitHub username and repository name
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter the name of your configuration repository: " REPO_NAME

# Install dependencies
sudo pacman -Sy git base-devel swww hyprlock hypridle waypaper mako wl-clipboard wl-clip-persist udiskie
bluez bluez-utils blueman pipewire-pulse networkmanager kio-admin kio-gdrive qt5-wayland qt6-wayland yazi file ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono ttf-cascadia-code-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-hack-nerd ttf-roboto-mono-nerd ttf-ubutu-nerd ttf-jetbrains-mono-nerd ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick vlc timg lua luarocks 

# Clone the repository
echo "Cloning your configuration repository from GitHub..."
git clone "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git" "/tmp/$REPO_NAME"

# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Failed to clone the repository. Please check your username and repository name."
    exit 1
fi

# Create necessary directories
echo "Creating configuration directories..."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/waypaper
mkdir -p ~/.config/yazi

# Function to copy and backup existing files
copy_and_backup() {
    SOURCE_FILE=$1
    DEST_FILE=$2

    if [ -f "$DEST_FILE" ]; then
        echo "Backing up existing $DEST_FILE to $DEST_FILE.bak"
        mv "$DEST_FILE" "$DEST_FILE.bak"
    fi
    echo "Copying $SOURCE_FILE to $DEST_FILE"
    cp "$SOURCE_FILE" "$DEST_FILE"
}

# Set my .bashrc
copy_and_backup "/tmp/$REPO_NAME/.bashrc" ~.bashrc

# Restore Hyprland configurations
copy_and_backup -r "/tmp/$REPO_NAME/hypr/*" ~/.config/hypr/

# Restore waybar configfurations
copy_and_backup -r "/tmp/$REPO_NAME/waybar/*" ~/.config/waybar

# Restore Wofi configurations
copy_and_backup -r "/tmp/$REPO_NAME/wofi/*" ~/.config/wofi/

# Restore yazi configurations
copy_and_backup -r "/tmp/$REPO_NAME/yazi/*" ~/.config/yazi/

# Clean up the cloned repository
rm -rf "/tmp/$REPO_NAME"

echo "Configuration files have been restored successfully!"
