# SM64DS Analog Hack — Steam Deck

Permite jugar **Super Mario 64 DS** con el joystick analógico izquierdo de la Steam Deck, usando una versión modificada de melonDS que activa el addon `Analog Input (Homebrew)` mediante un argumento de línea de comandos.

> Desarrollado y probado exclusivamente en **Steam Deck (SteamOS)**. Cualquier intento en otra distribución de Linux queda fuera del alcance de este proyecto.

---

## Créditos

- **melonDS** — Emulador base: https://melonds.kuribo64.net
- **Analog Hack para SM64DS** — Modificación original del emulador (rama `feature/slot2-analog`)
- **Gemini** — Asistencia en las etapas iniciales del proyecto
- **Claude (Anthropic)** — Diagnóstico, modificación del código fuente y empaquetado del AppImage

---

## Requisitos

- Steam Deck con SteamOS
- ROM de **Super Mario 64 DS** (versión compatible con el hack analógico, formato `.nds`)
- El archivo `melonDS-AnalogHack-x86_64.AppImage` (incluido en este repositorio)

---

## Instalación

### 1. Descargar el AppImage

Descarga `melonDS-AnalogHack-x86_64.AppImage` desde la sección [Releases](../../releases) de este repositorio y colócalo donde prefieras, por ejemplo:

```
/home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

Dale permisos de ejecución:

```bash
chmod +x /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

### 2. Crear el script de lanzamiento

Copia la plantilla `launch.sh` incluida en este repositorio o créala manualmente:

```bash
nano /home/deck/Desktop/SM64DS-Analog.sh
```

Contenido (ajusta las rutas a tu configuración):

```bash
#!/bin/bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog /ruta/a/tu/SM64DS.nds
```

Dale permisos de ejecución:

```bash
chmod +x /home/deck/Desktop/SM64DS-Analog.sh
```

### 3. Añadir a Steam

1. Abre Steam en **Modo Escritorio**
2. Ve a **Juegos → Añadir juego que no es de Steam**
3. Selecciona `SM64DS-Analog.sh`
4. Guarda y cambia al **Modo Juego**

---

## Uso

Lanza el juego desde Steam normalmente. El hack se activa automáticamente gracias al flag `--slot2-analog`.

Si prefieres lanzarlo desde terminal:

```bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog /ruta/a/tu/SM64DS.nds
```

---

## Cómo funciona

El AppImage incluye una versión de melonDS con una modificación en el parser de argumentos CLI (`CLI.cpp`, `CLI.h`, `main.cpp`) que añade el flag `--slot2-analog`. Al detectarlo, llama a `loadGBAAddon(GBAAddon_Analog)` antes de cargar la ROM, activando el addon de joystick analógico sin necesidad de interacción manual con los menús.

---

## Archivos incluidos

| Archivo | Descripción |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Emulador modificado con soporte para `--slot2-analog` |
| `launch.sh` | Plantilla de script de lanzamiento |
| `README.md` | Este archivo (inglés) |
| `README.es.md` | Este archivo (español) |
