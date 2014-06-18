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

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Set highlight colour to green
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

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

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

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
# Input
################################################################################

# Tap to click for this user and for login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a REALLY fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Set up British English locale
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Use London timezone
systemsetup -settimezone "Europe/London" > /dev/null

# Disable automatic emoji substitution in Messages
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

################################################################################
# Screen
################################################################################

# Require password immediately after sleep/screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

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

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don't rearrange Spaces based on recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the Dock auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Enable auto-hide
defaults write com.apple.dock autohide -bool true

################################################################################
# Kill affected applications
################################################################################

# Reset launchpad
[ -e ~/Library/Application\ Support/Dock*.db ] && rm ~/Library/Application\ Support/Dock*.db

for app in "Dashboard" "Dock" "Finder" "Messages" "SystemUIServer"; do
    killall "$app" > /dev/null 2>&1
done

echo "Done. May need to logout/restart to apply everything."
