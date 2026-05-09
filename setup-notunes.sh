#!/bin/bash
# Configure noTunes to open yt music instead of Apple Music
# Install noTunes first: brew install --cask notunes

echo "🎵 Setting up noTunes for yt music..."

# Check if noTunes installed
if [ ! -d "/Applications/noTunes.app" ]; then
    echo "Installing noTunes..."
    brew install --cask notunes 2>/dev/null || {
        echo "❌ Could not install noTunes. Install manually: brew install --cask notunes"
        exit 1
    }
fi

# Configure
defaults write com.tombonez.noTunes replacement "com.github.th-ch.youtube-music"
defaults write com.tombonez.noTunes showIcon -bool false

# Restart noTunes
pkill -f noTunes 2>/dev/null
sleep 1
open -a noTunes

echo "✅ Play/Pause button now opens yt music instead of Apple Music!"
