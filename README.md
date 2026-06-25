# SM64DS Analog Hack — Steam Deck

Play **Super Mario 64 DS** with the Steam Deck's left analog stick, using a custom-built AppImage of melonDS that activates the `Analog Input (Homebrew)` Slot-2 addon via a command-line flag.

> Developed and tested exclusively on **Steam Deck (SteamOS)**. Other Linux distributions are outside the scope of this project.

---

## How it works

The AppImage contains a modified build of melonDS with custom changes to the CLI argument parser (`CLI.cpp`, `CLI.h`, `main.cpp`) that add a `--slot2-analog` flag. When detected, it calls `loadGBAAddon(GBAAddon_Analog)` before loading the ROM, activating the analog stick addon automatically — no manual menu interaction needed.

> **Note:** The `--slot2-analog` flag does not exist in any official or fork version of melonDS. It was created specifically for this project. This AppImage and launch script have no known equivalent anywhere else.

---

## Credits

- **[Arisotura](https://github.com/Arisotura/melonDS)** — Original melonDS emulator
- **[nadiaholmquist](https://github.com/nadiaholmquist/melonDS)** — Fork of melonDS that introduced the `feature/slot2-analog` branch, Linux build instructions, and an AppImage (no longer available). This project is based on her work.
- **[LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME)** — Original analog stick hack for SM64DS (cheat code / IPS patch that makes the game read analog input from the emulator)
- **Gemini** — Assistance during the early stages of the project
- **Claude (Anthropic)** — Source code diagnosis, CLI modification, and AppImage packaging

---

## Requirements

- Steam Deck running SteamOS
- A **Super Mario 64 DS** ROM patched for analog input (`.nds` format) — see [LRFLEW's repo](https://github.com/LRFLEW/AM64DS_DeSmuME) for the cheat code / IPS patch
- The `melonDS-AnalogHack-x86_64.AppImage` from the [Releases](../../releases) page

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

### 2. Set up the launch script

Copy the `launch.sh` template from this repository, or create it manually:

```bash
nano /home/deck/Desktop/SM64DS-Analog.sh
```

Contents (adjust paths to match your setup):

```bash
#!/bin/bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /path/to/your/SM64DS_Analog.nds
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

## Optional: Configure R4 button to toggle screens

melonDS uses `Tab` by default to cycle through screen layouts. To bind this to the R4 button on your Steam Deck:

1. In Game Mode, select the game → **...** → **Properties** → **Controller** → **Edit layout**
2. Find the **R4** button and assign it as a keystroke: `Tab`
3. Save the profile (e.g. name it *"SM64DS Analog"*)

You can also bind `F` to toggle fullscreen if needed.

---

## Usage

Launch the game from Steam normally. The hack activates automatically via the `--slot2-analog` flag.

To launch from terminal:

```bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /path/to/your/SM64DS_Analog.nds
```

---

## Why not just use the standard melonDS commands for Linux?

The official melonDS Linux build instructions (Ubuntu/Arch/Fedora) use `apt`, `pacman`, or `dnf` to install dependencies and compile from source. On SteamOS, this doesn't work reliably because:

- The root filesystem is **read-only** and resets on every system update
- Package managers like `apt` and `pacman` are not available natively

This AppImage bundles all dependencies and survives SteamOS updates. [Distrobox](https://github.com/89luca89/distrobox) was used during the build process to compile in a proper Linux environment inside SteamOS.

---

## Troubleshooting

**AppImage won't open**
Make sure it has execute permissions: `chmod +x melonDS-AnalogHack-x86_64.AppImage`

**Game launches but analog stick doesn't work**
Your ROM may not be patched. Apply the cheat code or IPS patch from [LRFLEW's repository](https://github.com/LRFLEW/AM64DS_DeSmuME) first.

**Black screen or no display in Game Mode**
The `DISPLAY=:0` variable is required when launching from Steam in Game Mode. Make sure it's present in your script.

---

## Included files

| File | Description |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Modified melonDS build with `--slot2-analog` support |
| `launch.sh` | Launch script template |
| `README.md` | This file (English) |
| `README.es.md` | Spanish version |
