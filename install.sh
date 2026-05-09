#!/bin/bash
# Quick install: Downloads DMG and installs yt music

echo "📥 Installing yt music..."

REPO="TheNickCoolst/yt-music"
LATEST_DMG=$(curl -sL "https://api.github.com/repos/$REPO/releases/latest" | \
    python3 -c "import sys,json; d=json.load(sys.stdin); [print(a['browser_download_url']) for a in d['assets'] if a['name'].endswith('.dmg')]" 2>/dev/null)

if [ -z "$LATEST_DMG" ]; then
    echo "❌ Could not find latest DMG"
    exit 1
fi

curl -# -L -o /tmp/yt-music.dmg "$LATEST_DMG"
hdiutil attach /tmp/yt-music.dmg -nobrowse -quiet

VOL=$(ls /Volumes/ | grep -i "yt music" | head -1)
if [ -d "/Applications/yt music.app" ] || [ -d "/Applications/YouTube Music.app" ]; then
    rm -rf "/Applications/YouTube Music.app" 2>/dev/null
fi
cp -R "/Volumes/$VOL/yt music.app" "/Applications/YouTube Music.app"
xattr -cr "/Applications/YouTube Music.app"

hdiutil detach "/Volumes/$VOL" -quiet
rm /tmp/yt-music.dmg

echo "✅ yt music installed! Open from Applications or Launchpad."
