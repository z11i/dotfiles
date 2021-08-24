#!/usr/bin/env bash

# show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# save screenshots to ~/Pictures
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# disable accent menu on keyboard hold
defaults write -g ApplePressAndHoldEnabled -bool false

killall Finder
