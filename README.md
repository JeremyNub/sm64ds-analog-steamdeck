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

From the [Releases](../../releases) page, download:
- `melonDS-AnalogHack-x86_64.AppImage`
- `SM64DS-Analog-SteamDeck.zip`

---

### Method A — Dolphin file manager (Steam Deck, no terminal needed)

1. Open **Dolphin** and extract `SM64DS-Analog-SteamDeck.zip` — right-click → **Extract archive here**
2. Right-click `melonDS-AnalogHack-x86_64.AppImage` → **Properties** → **Permissions** → check **Is executable**
3. Right-click `launch.sh` → **Properties** → **Permissions** → check **Is executable**
4. Open **Steam** in Desktop Mode → **Games → Add a Non-Steam Game** → select `launch.sh`
5. Switch to **Game Mode** and launch

> No editing needed — `launch.sh` automatically finds both the AppImage and the patched ROM anywhere on your Steam Deck.

---

### Method B — Terminal (advanced users / other Linux distros)

```bash
# Extract the zip
unzip SM64DS-Analog-SteamDeck.zip
cd SM64DS-Analog-SteamDeck

# Make both files executable
chmod +x melonDS-AnalogHack-x86_64.AppImage launch.sh

# Run
./launch.sh
```

To add to Steam, go to **Games → Add a Non-Steam Game** and select `launch.sh`.

---

## How the launch script works

`launch.sh` automatically finds the AppImage and ROM by their MD5 checksum — no matter what they're named or where they are (within the search paths below). If a file isn't found automatically, a file picker opens so you can select it manually.

**AppImage search paths:**
- Same folder as `launch.sh`
- `~/Desktop`
- `~/Downloads`
- `~/Applications`
- `~/.local/bin`

**ROM search paths:**
- `~/Downloads`
- `~/Desktop`
- `~/Emulation/roms/nds`
- `~/ROMs/nds`
- Same folder as `launch.sh`

> If neither the AppImage nor the ROM are in any of these paths, a file picker will open automatically. The script verifies the MD5 of any manually selected file to ensure it's the correct one.

On first launch, `launch.sh` also copies `melonDS.toml` to `~/.config/melonDS/`, pre-configuring controls and display for Steam Deck. Existing melonDS configs are not overwritten.

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
DISPLAY=:0 ./melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /path/to/your/SM64DS_Analog.nds
```

---

## Why not just use nadiaholmquist's Linux build instructions?

[nadiaholmquist's fork](https://github.com/nadiaholmquist/melonDS) includes Linux build instructions for Ubuntu, Arch, and Fedora using `apt`, `pacman`, or `dnf` to install dependencies and compile from source. On SteamOS, this doesn't work reliably because:

- The root filesystem is **read-only** and resets on every system update
- Package managers like `apt` and `pacman` are not available natively

This AppImage bundles all dependencies and survives SteamOS updates. [Distrobox](https://github.com/89luca89/distrobox) was used during the build process to compile in a proper Linux environment inside SteamOS.

---

## Troubleshooting

**AppImage won't open**
Make sure it has execute permissions: `chmod +x melonDS-AnalogHack-x86_64.AppImage`

**Game launches but analog stick doesn't work**
Your ROM may not be patched. Apply the cheat code or IPS patch from [LRFLEW's repository](https://github.com/LRFLEW/AM64DS_DeSmuME) first.

**Script says the AppImage is not the correct fork**
Download it from the [Releases](../../releases) page of this repository, not from the official melonDS website.

**Script says the ROM is not the correct patched version**
Make sure you applied the analog hack patch from [LRFLEW's repository](https://github.com/LRFLEW/AM64DS_DeSmuME) to your SM64DS ROM.

**Black screen or no display in Game Mode**
The `DISPLAY=:0` variable is required when launching from Steam in Game Mode. Make sure it's present in your script.

---

## Included files

| File | Description |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Modified melonDS build with `--slot2-analog` support |
| `launch.sh` | Launch script — auto-detects AppImage and ROM by MD5, copies config on first run |
| `melonDS.toml` | Pre-configured settings for Steam Deck (controls, display, 4x resolution) |
| `README.md` | This file (English) |
| `README.es.md` | Spanish version |
