# 🎵 yt music — YouTube Music for Mac

Einfach installierbare YouTube Music Desktop App für macOS.

## Installation

```bash
curl -sL https://raw.githubusercontent.com/TheNickCoolst/yt-music/main/install.sh | bash
```

Oder: DMG von [Releases](https://github.com/TheNickCoolst/yt-music/releases) herunterladen und `yt music.app` in den Programme-Ordner ziehen.

## Features

- 🎧 YouTube Music als native Mac-App
- ⏯️ **Play/Pause-Button** → öffnet yt music statt Apple Music (mit noTunes)
- 🇩🇪 Deutsche Sprache vorkonfiguriert
- 🚀 Startet bei Login (optional)
- 🔑 User-Agent-Fix für Google-Login

## noTunes Setup

Damit der Play-Button yt music statt Apple Music öffnet:

```bash
./setup-notunes.sh
```

## Selbst bauen

```bash
./create-dmg.sh
```

---

Basiert auf [pear-devs/pear-desktop](https://github.com/pear-devs/pear-desktop) (GPL-3.0)
