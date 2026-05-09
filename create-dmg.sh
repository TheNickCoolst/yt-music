#!/bin/bash
# Creates a DMG of the configured YouTube Music app
# Usage: ./create-dmg.sh [app-path] [output-dmg]

APP_PATH="${1:-/Applications/YouTube Music.app}"
OUTPUT="${2:-yt-music.dmg}"
TMPDIR="/tmp/yt-music-dmg-$$"

echo "📦 Creating yt music DMG..."

# Download latest YouTube Music if not present
if [ ! -d "$APP_PATH" ]; then
    echo "Downloading YouTube Music Desktop App..."
    DL_URL=$(curl -sL "https://api.github.com/repos/pear-devs/pear-desktop/releases/latest" | \
        python3 -c "import sys,json; d=json.load(sys.stdin); [print(a['browser_download_url']) for a in d['assets'] if 'arm64' in a['name'] and a['name'].endswith('.dmg')]" 2>/dev/null)
    
    if [ -z "$DL_URL" ]; then
        echo "❌ Could not find download URL"
        exit 1
    fi
    
    curl -# -L -o /tmp/ytmusic-install.dmg "$DL_URL"
    hdiutil attach /tmp/ytmusic-install.dmg -nobrowse -quiet
    
    VOL=$(ls /Volumes/ | grep -i "YouTube Music" | head -1)
    cp -R "/Volumes/$VOL/YouTube Music.app" "$APP_PATH"
    hdiutil detach "/Volumes/$VOL" -quiet
    rm /tmp/ytmusic-install.dmg
fi

# Setup staging
mkdir -p "$TMPDIR"
cp -R "$APP_PATH" "$TMPDIR/yt music.app"

# Fix quarantine
xattr -cr "$TMPDIR/yt music.app"

# Create default config
mkdir -p "$TMPDIR/yt music.app/Contents/Resources/defaults"
python3 -c "
import json
config = {
    'url': 'https://music.youtube.com',
    'options': {
        'tray': False, 'appVisible': True, 'autoUpdates': True,
        'alwaysOnTop': False, 'hideMenu': False, 'startAtLogin': False,
        'disableHardwareAcceleration': False, 'restartOnConfigChanges': False,
        'resumeOnStart': True, 'overrideUserAgent': True,
        'language': 'de'
    }
}
with open('$TMPDIR/yt music.app/Contents/Resources/defaults/config.json', 'w') as f:
    json.dump(config, f, indent='\t', ensure_ascii=False)
print('⚙️  Default config created')
"

# Create DMG
hdiutil create -fs HFS+ -volname "yt music" -srcfolder "$TMPDIR" "$OUTPUT" 2>&1

# Cleanup
rm -rf "$TMPDIR"

echo "✅ DMG created: $OUTPUT"
ls -lh "$OUTPUT"
