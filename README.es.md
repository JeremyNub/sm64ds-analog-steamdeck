# SM64DS Analog Hack — Steam Deck

Juega **Super Mario 64 DS** con el joystick analógico izquierdo de la Steam Deck, usando una AppImage personalizada de melonDS que activa el addon `Analog Input (Homebrew)` del Slot-2 mediante un argumento de línea de comandos.

> Desarrollado y probado exclusivamente en **Steam Deck (SteamOS)**. Otras distribuciones de Linux quedan fuera del alcance de este proyecto.

---

## Cómo funciona

La AppImage incluye una versión modificada de melonDS con cambios en el parser de argumentos CLI (`CLI.cpp`, `CLI.h`, `main.cpp`) que añaden el flag `--slot2-analog`. Al detectarlo, se llama a `loadGBAAddon(GBAAddon_Analog)` antes de cargar la ROM, activando el addon de joystick analógico automáticamente, sin necesidad de interacción manual con los menús.

> **Nota:** El flag `--slot2-analog` no existe en ninguna versión oficial ni en ningún fork de melonDS. Fue creado específicamente para este proyecto. Esta AppImage y el script de lanzamiento no tienen equivalente conocido en ningún otro lugar.

---

## Créditos

- **[Arisotura](https://github.com/Arisotura/melonDS)** — Emulador melonDS original
- **[nadiaholmquist](https://github.com/nadiaholmquist/melonDS)** — Fork de melonDS que introdujo la rama `feature/slot2-analog`, instrucciones de compilación en Linux y una AppImage (ya no disponible). Este proyecto está basado en su trabajo.
- **[LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME)** — Hack analógico original para SM64DS (código de trucos / parche IPS que hace que el juego lea el input analógico del emulador)
- **Gemini** — Asistencia en las etapas iniciales del proyecto
- **Claude (Anthropic)** — Diagnóstico del código fuente, modificación del CLI y empaquetado de la AppImage

---

## Requisitos

- Steam Deck con SteamOS
- ROM de **Super Mario 64 DS** parcheada para input analógico (formato `.nds`) — ver el [repositorio de LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME) para el código de trucos / parche IPS
- El archivo `melonDS-AnalogHack-x86_64.AppImage` desde la sección [Releases](../../releases)

---

## Instalación

### 1. Descargar la AppImage

Descarga `melonDS-AnalogHack-x86_64.AppImage` desde la sección [Releases](../../releases) y colócala donde prefieras, por ejemplo:

```
/home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

Dale permisos de ejecución:

```bash
chmod +x /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage
```

### 2. Configurar el script de lanzamiento

Copia la plantilla `launch.sh` de este repositorio o créala manualmente:

```bash
nano /home/deck/Desktop/SM64DS-Analog.sh
```

Contenido (ajusta las rutas a tu configuración):

```bash
#!/bin/bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /ruta/a/tu/SM64DS_Analog.nds
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

## Opcional: Configurar el botón R4 para alternar pantallas

melonDS usa `Tab` por defecto para alternar entre layouts de pantalla. Para asignarlo al botón R4 de la Steam Deck:

1. En Modo Juego, selecciona el juego → **...** → **Propiedades** → **Controlador** → **Editar layout**
2. Busca el botón **R4** y asígnalo como tecla: `Tab`
3. Guarda el perfil (por ejemplo con el nombre *"SM64DS Analog"*)

También puedes asignar `F` para alternar entre pantalla completa y ventana.

---

## Uso

Lanza el juego desde Steam normalmente. El hack se activa automáticamente gracias al flag `--slot2-analog`.

Para lanzarlo desde terminal:

```bash
DISPLAY=:0 /home/deck/Desktop/melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /ruta/a/tu/SM64DS_Analog.nds
```

---

## ¿Por qué no usar los comandos estándar de melonDS para Linux?

Las instrucciones oficiales de compilación de melonDS en Linux (Ubuntu/Arch/Fedora) usan `apt`, `pacman` o `dnf` para instalar dependencias y compilar desde el código fuente. En SteamOS esto no funciona de forma fiable porque:

- El sistema de archivos raíz es **de solo lectura** y se resetea con cada actualización del sistema
- Gestores de paquetes como `apt` o `pacman` no están disponibles de forma nativa

Esta AppImage incluye todas las dependencias y sobrevive a las actualizaciones de SteamOS. Se usó [Distrobox](https://github.com/89luca89/distrobox) durante el proceso de compilación para construir en un entorno Linux adecuado dentro de SteamOS.

---

## Solución de problemas

**La AppImage no abre**
Asegúrate de que tiene permisos de ejecución: `chmod +x melonDS-AnalogHack-x86_64.AppImage`

**El juego abre pero el analógico no funciona**
Es posible que tu ROM no esté parcheada. Aplica primero el código de trucos o el parche IPS del [repositorio de LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME).

**Pantalla negra o sin imagen en Modo Juego**
La variable `DISPLAY=:0` es necesaria al lanzar desde Steam en Modo Juego. Asegúrate de que está presente en tu script.

---

## Archivos incluidos

| Archivo | Descripción |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Build modificado de melonDS con soporte para `--slot2-analog` |
| `launch.sh` | Plantilla del script de lanzamiento |
| `README.md` | Versión en inglés |
| `README.es.md` | Este archivo (español) |
