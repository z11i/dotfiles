#!/usr/bin/env bash

# show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show scrollbar when scrolling
defaults write -g AppleShowScrollBars -string WhenScrolling

# show path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# do not reorder spaces
defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock

# save screenshots to ~/Pictures
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# disable accent menu on keyboard hold
defaults write -g ApplePressAndHoldEnabled -bool false

# Safari show full URL
defaults write com.apple.safari "ShowFullURLInSmartSearchField" -bool "true" && killall Safari

killall Finder
