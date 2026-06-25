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

Desde la sección [Releases](../../releases), descarga:
- `melonDS-AnalogHack-x86_64.AppImage`
- `SM64DS-Analog-SteamDeck.zip`

---

### Método A — Dolphin (Steam Deck, sin terminal)

1. Abre **Dolphin** y extrae `SM64DS-Analog-SteamDeck.zip` — clic derecho → **Extraer archivo aquí**
2. Mueve `melonDS-AnalogHack-x86_64.AppImage` a la carpeta extraída
3. Clic derecho en `melonDS-AnalogHack-x86_64.AppImage` → **Propiedades** → **Permisos** → marca **Es ejecutable**
4. Clic derecho en `launch.sh` → **Abrir con** → **Kate** (o cualquier editor de texto), actualiza la ruta de tu ROM y guarda:
   ```
   ROM="/home/deck/donde/este/tu/SM64DS_Analog.nds"
   ```
5. Clic derecho en `launch.sh` → **Propiedades** → **Permisos** → marca **Es ejecutable**
6. Abre **Steam** en Modo Escritorio → **Juegos → Añadir juego que no es de Steam** → selecciona `launch.sh`
7. Cambia al **Modo Juego** y lanza el juego

> En el primer lanzamiento, el script copia automáticamente `melonDS.toml` a `~/.config/melonDS/`, configurando los controles y la pantalla para Steam Deck. Si ya tienes una config de melonDS, no será sobreescrita.

---

### Método B — Terminal (usuarios avanzados / otras distros de Linux)

```bash
# Extraer el zip
unzip SM64DS-Analog-SteamDeck.zip
cd SM64DS-Analog-SteamDeck

# Mover la AppImage aquí
mv ~/Downloads/melonDS-AnalogHack-x86_64.AppImage .

# Dar permisos de ejecución a ambos archivos
chmod +x melonDS-AnalogHack-x86_64.AppImage launch.sh

# Editar la ruta de la ROM
nano launch.sh

# Ejecutar
./launch.sh
```

Para añadir a Steam, ve a **Juegos → Añadir juego que no es de Steam** y selecciona `launch.sh`.

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

**Pantalla negra o sin imagen en Modo Juego**
La variable `DISPLAY=:0` es necesaria al lanzar desde Steam en Modo Juego. Asegúrate de que está presente en tu script.

---

## Archivos incluidos

| Archivo | Descripción |
|---|---|
| `melonDS-AnalogHack-x86_64.AppImage` | Build modificado de melonDS con soporte para `--slot2-analog` |
| `launch.sh` | Script de lanzamiento — copia el config en el primer uso y lanza el emulador |
| `melonDS.toml` | Configuración preestablecida para Steam Deck (controles, pantalla, resolución 4x) |
| `README.md` | Versión en inglés |
| `README.es.md` | Este archivo (español) |
