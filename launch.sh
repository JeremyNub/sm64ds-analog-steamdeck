#!/bin/bash
# ============================================================
# SM64DS Analog Hack — Script de lanzamiento / Launch script
# ============================================================
# Ajusta las rutas a tu configuración antes de usar.
# Adjust the paths to match your setup before use.
# ============================================================

APPIMAGE="/home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage"
ROM="/ruta/a/tu/SM64DS.nds"
# ROM="/path/to/your/SM64DS.nds"

DISPLAY=:0 "$APPIMAGE" --slot2-analog "$ROM"
