# odin-raylib-starter

A learning project — an isometric pixel game built with Odin and raylib.

## Dependencies

### macOS

Only **Odin** is required. Raylib ships as a static library with the vendor binding — no separate system packages needed.

```sh
brew install odin
```

### Linux

The vendor binding includes `libraylib.a`, but the linker needs system libraries (X11 / Wayland, OpenGL, etc.):

```sh
# Debian/Ubuntu
sudo apt install libraylib-dev libgl-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev

# Arch
sudo pacman -S raylib
```

### Windows

Only Odin is required. The static library `vendor/raylib/windows/raylib.lib` is bundled.

---

## Build & run

```sh
odin build .
odin run .
```

## Structure

```
.
├── main.odin    # game loop
├── player.png   # player sprite
├── ROADMAP.md
└── README.md
```
