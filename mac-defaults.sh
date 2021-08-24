#!/usr/bin/env bash

# show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# save screenshots to ~/Pictures
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

killall Finder
