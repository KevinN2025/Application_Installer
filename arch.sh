#!/bin/bash

print_header() {
  local title="$1"
  local width=72
  local border

  border=$(printf '%*s' "$width" '' | tr ' ' '=')

  if command -v tput >/dev/null 2>&1 && [ -n "${TERM:-}" ]; then
    printf '\n%s%s%s\n' "$(tput bold)$(tput setaf 6)" "$border" "$(tput sgr0)"
    printf '%s  %s%s\n' "$(tput bold)$(tput setaf 6)" "$title" "$(tput sgr0)"
    printf '%s%s%s\n\n' "$(tput bold)$(tput setaf 6)" "$border" "$(tput sgr0)"
  else
    printf '\n%s\n' "$border"
    printf '  %s\n' "$title"
    printf '%s\n\n' "$border"
  fi
}

# Arch

# Update Arch
print_header "Updating Arch"
if sudo pacman -Syu; then
  echo "Arch update completed successfully"
else
  echo "Arch update failed"
  exit 1
fi

# Install dependencies
print_header "Installing Dependencies"
echo "Packages: git, curl, wget, neovim, btop, cpufetch, fastfetch, alacritty, bmon, tor, zsh"
if sudo pacman -S git curl wget neovim btop cpufetch fastfetch alacritty bmon tor zsh; then
  echo "Dependency installation completed successfully"
else
  echo "Dependency installation failed"
  exit 1
fi

# Install languages
print_header "Installing Programming Languages"
echo "Packages: Go, Rust, Java, C, C++, Ruby, Python"
if sudo pacman -S go rust jdk-openjdk gcc ruby python; then
  echo "Programming language installation completed successfully"
else
  echo "Programming language installation failed"
  exit 1
fi

# Install yay from AUR GitHub repository
print_header "Preparing yay Installation"
echo "Installing build tools required for yay"
if sudo pacman -S base-devel; then
  echo "Build tools for yay installed successfully"
else
  echo "Failed to install build tools for yay"
  exit 1
fi

if command -v yay >/dev/null 2>&1; then
  echo "yay is already installed, skipping installation"
else
  print_header "Fetching yay Source"
  echo "Preparing yay source directory"
  rm -rf /tmp/yay

  echo "Cloning yay from GitHub"
  if git clone https://aur.archlinux.org/yay.git /tmp/yay; then
    echo "yay repository cloned successfully"
  else
    echo "Failed to clone yay repository"
    exit 1
  fi

  print_header "Building yay"
  echo "Building and installing yay"
  cd /tmp/yay || exit 1
  if makepkg -si; then
    echo "yay installed successfully"
  else
    echo "yay installation failed"
    exit 1
  fi
  cd - >/dev/null || exit 1
fi

if command -v yay >/dev/null 2>&1; then
  echo "yay is available"
else
  echo "yay installation failed"
  exit 1
fi

# Install penetration testing applications
print_header "Installing Penetration Testing Applications"
echo "Packages: nmap, wireshark-qt, burpsuite, sqlmap, hydra, aircrack-ng, metasploit, bettercap, john"
if yay -S nmap wireshark-qt burpsuite sqlmap hydra aircrack-ng metasploit bettercap john; then
  echo "Penetration testing applications installed successfully"
else
  echo "Penetration testing application installation failed"
  exit 1
fi

print_header "Arch Setup Complete"
