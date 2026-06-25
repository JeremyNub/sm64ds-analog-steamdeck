# SM64DS Analog Hack — Steam Deck

Enables playing **Super Mario 64 DS** with the Steam Deck's left analog stick, using a modified build of melonDS that activates the `Analog Input (Homebrew)` addon via a command-line argument.

> Developed and tested exclusively on **Steam Deck (SteamOS)**. Any attempt to run this on other Linux distributions is outside the scope of this project.

---

## Credits

- **melonDS** — Base emulator: https://melonds.kuribo64.net
- **Analog Hack for SM64DS** — Original emulator modification (branch `feature/slot2-analog`)
- **Gemini** — Assistance during the early stages of the project
- **Claude** — Source code diagnosis, modification, and AppImage packaging

---

## Requirements

- Steam Deck running SteamOS
- A **Super Mario 64 DS** ROM (analog hack-compatible version, `.nds` format)
- The `melonDS-AnalogHack-x86_64.AppImage` file (included in this repository)

---

## Installation

### 1. Download the AppImage

Download `melonDS-AnalogHack-x86_64.AppImage` from the [Releases](../../releases) section and place it wherever you prefer, for example:

```
/home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

Make it executable:

```bash
chmod +x /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

### 2. Create the launch script

Copy the `launch.sh` template included in this repository, or create it manually:

```bash
nano /home/deck/Desktop/SM64DS-Analog.sh
```

Contents (adjust paths to match your setup):

```bash
#!/bin/bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog /path/to/your/SM64DS.nds
```

Make it executable:

```bash
chmod +x /home/deck/Desktop/SM64DS-Analog.sh
```

### 3. Add to Steam

1. Open Steam in **Desktop Mode**
2. Go to **Games → Add a Non-Steam Game**
3. Select `SM64DS-Analog.sh`
4. Save and switch to **Game Mode**

---

## Usage

Launch the game from Steam normally. The hack activates automatically thanks to the `--slot2-analog` flag.

To launch from terminal:

```bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog /path/to/your/SM64DS.nds
```

---

## How it works

The AppImage contains a modified build of melonDS with changes to the CLI argument parser (`CLI.cpp`, `CLI.h`, `main.cpp`) that add the `--slot2-analog` flag. When detected, it calls `loadGBAAddon(GBAAddon_Analog)` before loading the ROM, activating the analog stick addon without any manual menu interaction.

---

## Included files

| File | Description |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Modified emulator with `--slot2-analog` support |
| `launch.sh` | Launch script template |
| `README.md` | This file (English) |
| `README.es.md` | Spanish version |
