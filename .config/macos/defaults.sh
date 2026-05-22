#!/usr/bin/env bash
set -euo pipefail

if ! command -v dockutil >/dev/null 2>&1; then
    brew install dockutil
fi

# Global macOS defaults
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain KeyRepeat -int 1

# Dock behavior.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Dock app side: no pinned apps, no recent apps.
dockutil --remove all --no-restart
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock show-recents -bool false

# Right side stacks.
dockutil --add /Applications \
  --view grid \
  --display folder \
  --sort name \
  --section others \
  --no-restart

dockutil --add "$HOME/Downloads" \
  --view grid \
  --display folder \
  --sort dateadded \
  --section others \
  --no-restart

killall cfprefsd 2>/dev/null || true
killall Dock || true
