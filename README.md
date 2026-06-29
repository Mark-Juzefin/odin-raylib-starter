# odin-raylib-starter

Мінімальний скелет проєкту на Odin + raylib.

## Залежності

### macOS
Потрібен лише **Odin**. Raylib поставляється у вигляді статичної бібліотеки
разом із vendor-біндінгом (`vendor/raylib/macos/libraylib.a`) — жодних
окремих системних пакетів встановлювати не треба.

```sh
brew install odin
```

### Linux
Тут ситуація інша: vendor-біндінг містить `libraylib.a`, але лінкер потребує
системних бібліотек (X11 / Wayland, OpenGL тощо). Встановити через пакетний
менеджер:

```sh
# Debian/Ubuntu
sudo apt install libraylib-dev libgl-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev

# Arch
sudo pacman -S raylib
```

Або зібрати raylib зі сходу: https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux

### Windows
Потрібен лише Odin (скрипти з офіційного сайту). Статична бібліотека
`vendor/raylib/windows/raylib.lib` іде в комплекті.

---

## Збірка та запуск

```sh
# зібрати
odin build . -out:game

# запустити
./game          # macOS / Linux
game.exe        # Windows
```

Одна команда для збірки + запуску:

```sh
odin run .
```

## Туторіал

Проєкт слідує серії "Gamedev for beginners using Odin and Raylib" від Karl Zylinski:

- Стаття (частина 1): https://zylinski.se/posts/gamedev-for-beginners-using-odin-and-raylib-1/
- YouTube плейлист: https://www.youtube.com/playlist?list=PLxE7SoPYTef1jYHJ6NxNgocVjQKkq7eEa

---

## Структура

```
.
├── main.odin   # єдиний файл з ігровим циклом
├── .gitignore
└── README.md
```
