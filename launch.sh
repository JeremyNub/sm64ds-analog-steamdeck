#!/bin/bash
# ============================================================
# SM64DS Analog Hack — Script de lanzamiento / Launch script
# ============================================================
# No editing needed — the script automatically finds the
# patched ROM and AppImage anywhere on your Steam Deck.
# ============================================================

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
# Hash de la ROM USA v1.1 (Revision 1) modificada con el parche 'S.MARIO64DS_ASME01_01.ips'
TARGET_ROM_MD5="a663a9b713edaa39554a72001fd60123"
TARGET_APPIMAGE_MD5="cb4bb29d3203db8fb604575fe6614fb7"

# Buscar el AppImage correcto por MD5 en rutas comunes
APPIMAGE=""
SEARCH_PATHS_APPIMAGE=(
    "$SCRIPT_DIR"
    "$HOME/Desktop"
    "$HOME/Downloads"
    "$HOME/Applications"
    "$HOME/.local/bin"
)

echo "Buscando AppImage..."
for dir in "${SEARCH_PATHS_APPIMAGE[@]}"; do
    [ -d "$dir" ] || continue
    while IFS= read -r -d '' file; do
        if [ "$(md5sum "$file" | cut -d' ' -f1)" = "$TARGET_APPIMAGE_MD5" ]; then
            APPIMAGE="$file"
            break 2
        fi
    done < <(find "$dir" -maxdepth 2 -name "*.AppImage" -print0 2>/dev/null)
done

if [ -z "$APPIMAGE" ]; then
    APPIMAGE=$(zenity --file-selection \
        --title="AppImage no encontrado — selecciónalo manualmente" \
        --file-filter="AppImage (*.AppImage)|*.AppImage" 2>/dev/null)
    if [ -z "$APPIMAGE" ]; then
        zenity --error --text="No se seleccionó ningún AppImage." 2>/dev/null
        exit 1
    fi
    if [ "$(md5sum "$APPIMAGE" | cut -d' ' -f1)" != "$TARGET_APPIMAGE_MD5" ]; then
        zenity --error --text="El AppImage seleccionado no es el fork correcto.\nDescárgalo desde la página de Releases del repositorio." 2>/dev/null
        exit 1
    fi
fi

# Buscar la ROM parcheada por MD5 en rutas comunes
ROM=""
SEARCH_PATHS_ROM=(
    "$HOME/Downloads"
    "$HOME/Desktop"
    "$HOME/Emulation/roms/nds"
    "$HOME/ROMs/nds"
    "$SCRIPT_DIR"
)

echo "Buscando ROM parcheada..."
for dir in "${SEARCH_PATHS_ROM[@]}"; do
    [ -d "$dir" ] || continue
    while IFS= read -r -d '' file; do
        if [ "$(md5sum "$file" | cut -d' ' -f1)" = "$TARGET_ROM_MD5" ]; then
            ROM="$file"
            break 2
        fi
    done < <(find "$dir" -maxdepth 2 -name "*.nds" -print0 2>/dev/null)
done

if [ -z "$ROM" ]; then
    ROM=$(zenity --file-selection \
        --title="ROM parcheada no encontrada — selecciónala manualmente" \
        --file-filter="NDS ROM (*.nds)|*.nds" 2>/dev/null)
    if [ -z "$ROM" ]; then
        zenity --error --text="No se seleccionó ninguna ROM." 2>/dev/null
        exit 1
    fi
    if [ "$(md5sum "$ROM" | cut -d' ' -f1)" != "$TARGET_ROM_MD5" ]; then
        zenity --error --text="El archivo seleccionado no es la ROM parcheada correcta.\n\nVerifica que aplicaste el parche 'S.MARIO64DS_ASME01_01.ips' sobre una ROM limpia USA v1.1 (Revision 1)." 2>/dev/null
        exit 1
    fi
fi

# Copiar config si no existe
CONFIG_DIR="$HOME/.config/melonDS"
if [ ! -f "$CONFIG_DIR/melonDS.toml" ]; then
    mkdir -p "$CONFIG_DIR"
    cp "$SCRIPT_DIR/melonDS.toml" "$CONFIG_DIR/melonDS.toml"
fi

DISPLAY=:0 "$APPIMAGE" --slot2-analog --fullscreen "$ROM"
