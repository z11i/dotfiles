#!/usr/bin/env bash

# show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

killall Finder
