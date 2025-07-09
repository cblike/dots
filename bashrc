# ~/.bashrc

# -----------------------------------------------------------------------------
# SHELL OPTIONS & ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------

# Set default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Set PATH to include local binaries
export PATH="$HOME/.local/bin:$PATH"

# Enable color in tools that support it
export CLICOLOR=1
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:or=31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:*.tar=31:*.tgz=31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.bz2=31:*.bz=31:*.tz=31:*.rpm=31:*.jar=31:*.rar=31:*.ace=31:*.zoo=31:*.cpio=31:*.7z=31:*.rz=31:*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.png=35:*.mov=35:*.mpg=35:*.mpeg=35:*.avi=35:*.fli=35:*.gl=35:*.dl=35:*.xcf=35:*.xwd=35:*.ogg=35:*.mp3=35:*.wav=35:"

# Set HISTFILE size and options
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=10000
shopt -s histappend

# Set default prompt
# PS1='[\u@\h \W]\$ '

# -----------------------------------------------------------------------------
# NORD THEME COLORS & GIT PROMPT
# -----------------------------------------------------------------------------

# Nord Theme colors
nord0='#2e3440'  # Polar Night
nord1='#3b4252'  #
nord2='#434c5e'  #
nord3='#4c566a'  #
nord4='#d8dee9'  # Snow Storm
nord5='#e5e9f0'  #
nord6='#eceff4'  #
nord7='#8fbcbb'  # Frost (Teal)
nord8='#88c0d0'  #
nord9='#81a1c1'  #
nord10='#5e81ac' #
nord11='#bf616a' # Aurora (Red)
nord12='#d08770' # (Orange)
nord13='#ebcb8b' # (Yellow)
nord14='#a3be8c' # (Green)
nord15='#b48ead' # (Purple)

# Function to parse Git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Custom prompt with Nord colors and Git integration
PS1="\[\033[38;5;250m\]\u\[\033[38;5;244m\]@\[\033[38;5;250m\]\h \[\033[38;5;244m\]\w\[\033[38;5;229m\]\$(parse_git_branch)\[\033[00m\]\n\$ "

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

# General
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias dotfiles='cd ~/.dotfiles' # Change to your dotfiles directory
alias sudo='sudo ' # Enable aliases for sudo

# Pacman and yay
alias update='sudo pacman -Syu && yay -Sua --noconfirm'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias aurinstall='yay -S'
alias aursearch='yay -Ss'

# BTRFS Maintenance
alias btrfs-list='sudo btrfs subvolume list /'
alias btrfs-balance='sudo btrfs balance start /'
alias btrfs-scrub='sudo btrfs scrub start /'
alias btrfs-status='sudo btrfs filesystem usage /'

# System and Utilities
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'
alias lock='loginctl lock-session'
alias bat='batcat' # For systems where bat is installed as batcat
alias vim='nvim'
alias vi='nvim'

# Clear screen
alias c='clear'

# -----------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------

# Create a directory and cd into it
mcd() {
    mkdir -p "$1" && cd "$1"
}

# Backup a file
bak() {
    cp "$1" "$1.bak"
}

# Extract most common archive types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------
# HYPRLAND SPECIFIC
# -----------------------------------------------------------------------------

# Start Hyprland if in a TTY
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi

# Load custom scripts if they exist
if [ -d ~/.bashrc.d ]; then
  for i in ~/.bashrc.d/*.sh; do
    if [ -r "$i" ]; then
      . "$i"
    fi
  done
  unset i
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

echo "Welcome back, $USER!"

export PATH="$HOME/.local/bin:$PATH"

fastfetch
