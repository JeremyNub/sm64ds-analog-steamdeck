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
- ROM de **Super Mario 64 DS** (formato `.nds`) parcheada específicamente con el archivo **`S.MARIO64DS_ASME01_01.ips`** (requiere estrictamente la ROM base **USA v1.1 / Revision 1**) — ver el [repositorio de LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME) para más detalles.
- El archivo `melonDS-AnalogHack-x86_64.AppImage` desde la sección [Releases](../../releases)

---

## Instalación

Desde la sección [Releases](../../releases), descarga:
- `melonDS-AnalogHack-x86_64.AppImage`
- `SM64DS-Analog-SteamDeck.zip`

---

### Método A — Dolphin (Steam Deck, sin terminal)

1. Abre **Dolphin** y extrae `SM64DS-Analog-SteamDeck.zip` — clic derecho → **Extraer archivo aquí**
2. Clic derecho en `melonDS-AnalogHack-x86_64.AppImage` → **Propiedades** → **Permisos** → marca **Es ejecutable**
3. Clic derecho en `launch.sh` → **Propiedades** → **Permisos** → marca **Es ejecutable**
4. Abre **Steam** en Modo Escritorio → **Juegos → Añadir juego que no es de Steam** → selecciona `launch.sh`
5. Cambia al **Modo Juego** y lanza el juego

> No es necesario editar nada — `launch.sh` encuentra automáticamente tanto la AppImage como la ROM parcheada en cualquier lugar de tu Steam Deck.

---

### Método B — Terminal (usuarios avanzados / otras distros de Linux)

```bash
# Extraer el zip
unzip SM64DS-Analog-SteamDeck.zip
cd SM64DS-Analog-SteamDeck

# Dar permisos de ejecución a ambos archivos
chmod +x melonDS-AnalogHack-x86_64.AppImage launch.sh

# Ejecutar
./launch.sh
```

Para añadir a Steam, ve a **Juegos → Añadir juego que no es de Steam** y selecciona `launch.sh`.

---

## Cómo funciona el script de lanzamiento

`launch.sh` encuentra automáticamente la AppImage y la ROM por su checksum MD5 — sin importar cómo se llamen ni dónde estén (dentro de las rutas de búsqueda indicadas abajo). Si no encuentra algún archivo automáticamente, se abre un selector de archivos para elegirlo manualmente.

**Rutas de búsqueda para la AppImage:**
- Misma carpeta que `launch.sh`
- `~/Desktop`
- `~/Downloads`
- `~/Applications`
- `~/.local/bin`

**Rutas de búsqueda para la ROM:**
- `~/Downloads`
- `~/Desktop`
- `~/Emulation/roms/nds`
- `~/ROMs/nds`
- Misma carpeta que `launch.sh`

> Si la AppImage o la ROM no están en ninguna de estas rutas, se abrirá automáticamente un selector de archivos. El script verifica el MD5 de cualquier archivo seleccionado manualmente para asegurarse de que es el correcto.

En el primer lanzamiento, el script también copia `melonDS.toml` a `~/.config/melonDS/`, configurando automáticamente los controles y la pantalla para Steam Deck. Las configuraciones existentes de melonDS no serán sobreescritas.

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
DISPLAY=:0 ./melonDS-AnalogHack-x86_64.AppImage --slot2-analog --fullscreen /ruta/a/tu/SM64DS_Analog.nds
```

---

## ¿Por qué no usar las instrucciones de compilación en Linux de nadiaholmquist?

El [fork de nadiaholmquist](https://github.com/nadiaholmquist/melonDS) incluye instrucciones de compilación en Linux para Ubuntu, Arch y Fedora usando `apt`, `pacman` o `dnf` para instalar dependencias y compilar desde el código fuente. En SteamOS esto no funciona de forma fiable porque:

- El sistema de archivos raíz es **de solo lectura** y se resetea con cada actualización del sistema
- Gestores de paquetes como `apt` o `pacman` no están disponibles de forma nativa

Esta AppImage incluye todas las dependencias y sobrevive a las actualizaciones de SteamOS. Se usó [Distrobox](https://github.com/89luca89/distrobox) durante el proceso de compilación para construir en un entorno Linux adecuado dentro de SteamOS.

---

## Solución de problemas

**La AppImage no abre**
Asegúrate de que tiene permisos de ejecución: `chmod +x melonDS-AnalogHack-x86_64.AppImage`

**El juego abre pero el analógico no funciona**
Es posible que tu ROM no esté parcheada. Aplica primero el código de trucos o el parche IPS del [repositorio de LRFLEW](https://github.com/LRFLEW/AM64DS_DeSmuME).

**El script dice que la AppImage no es el fork correcto**
Descárgala desde la sección [Releases](../../releases) de este repositorio, no desde el sitio oficial de melonDS.

**El script dice que la ROM no es la versión parcheada correcta**
Asegúrate de haber aplicado el parche **`S.MARIO64DS_ASME01_01.ips`** sobre una ROM limpia de **Super Mario 64 DS (USA) v1.1 (Revision 1)**. El script rechazará hashes de otras versiones o ROMs sin parchear.

**Pantalla negra o sin imagen en Modo Juego**
La variable `DISPLAY=:0` es necesaria al lanzar desde Steam en Modo Juego. Asegúrate de que está presente en tu script.

---

## Archivos incluidos

| Archivo | Descripción |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Build modificado de melonDS con soporte para `--slot2-analog` |
| `launch.sh` | Script de lanzamiento — detecta AppImage y ROM por MD5, copia config en el primer uso |
| `melonDS.toml` | Configuración preestablecida para Steam Deck (controles, pantalla, resolución 4x) |
| `README.md` | Versión en inglés |
| `README.es.md` | Este archivo (español) |
