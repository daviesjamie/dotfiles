#!/usr/bin/env bash

# Get administrator privileges
sudo -v

# Keep administrator privileges until scrpt finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################
# General
################################################################################

# Set computer name
read -p "What is this machine's name?:  " name
sudo scutil --set ComputerName $name
sudo scutil --set HostName $name
sudo scutil --set LocalHostName $name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $name

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the "Are you sure..." dialog when opening downloaded applications
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSAWindowResizeTime -float 0.001

# Stop Time Machine from prompting to use new hard drives as backups
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

################################################################################
# SSDs
################################################################################

# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Disable the sudden motion sensor as it's not useful for SSDs
sudo pmset -a sms 0

################################################################################
# Screen
################################################################################

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

################################################################################
# Finder
################################################################################

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When searching, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Stop creating .DS_Store files on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable AirDrop over Ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show ~/Library folder
chflags nohidden ~/Library

# Always expand "General", "Open With" and "Sharing & Permissions" in Get Info
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

################################################################################
# Dock
################################################################################

# Remove the Dock auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

################################################################################
# Kill affected applications
################################################################################

# Reset launchpad
[ -e ~/Library/Application\ Support/Dock*.db ] && rm ~/Library/Application\ Support/Dock*.db

for app in "Dashboard" "Dock" "Finder" "Messages" "SystemUIServer"; do
    killall "$app" > /dev/null 2>&1
done

echo "Done. May need to logout/restart to apply everything."
