---
title: Embedding game assets within your executable binary
url: embedding-game-assets-within-your-binary.html
date: 2025-04-08T16:13:13+02:00
type: post
draft: false
tags: []
---

## Why?

Normally, assets live outside the binary, but there is a valid reason to embed
them. Specially if you do not want to deal with reading and parsing external
files. This makes development and distribution much easier.

In this example, I'm using [raylib](https://github.com/raysan5/raylib) and C,
but this can also be done with [SDL](https://github.com/libsdl-org/SDL) or
other libraries.

Code for these notes is available as an
[embedding-binary-data.tar.xz](/assets/notes/embedding-binary-data.tar.xz)
tarball, but beware that this only includes the Linux build of raylib so please
change to appropriate operating system.

You can also check code on GitHub
[@mitjafelicijan/probe/c-embedding-data](https://github.com/mitjafelicijan/probe/tree/master/c-embedding-data).

## Project structure

We are going to keep it clean and simple here. I am using pre-build version of
raylib just to simplify compilation. All the code is located in the `main.c`
file, so refer to that.

```
├── data                            Contains assets
│   ├── armor.png                   Image example
│   └── dejavusans-mono.ttf         Font example
├── libs
│   └── raylib-5.5_linux_amd64      Includes prebuild raylib
├── main.c                          Main file
└── Makefile                        Build instruction
```

## Main game loop

We first need to setup main game loop and get the game running.

```c
#include <stdio.h>
#include "raylib.h"

int main(void) {
    SetConfigFlags(FLAG_WINDOW_RESIZABLE | FLAG_VSYNC_HINT | FLAG_WINDOW_HIGHDPI);
    InitWindow(900, 400, "Embedding assets");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(BLACK);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
```

And then prepare basic `Makefile` to compile this.

```make
RAYLIB_VER  := 5.5_linux_amd64
CC          ?= cc
CFLAGS      := -Wall -Wextra -Wunused -Wno-unused-parameter -Wswitch-enum -Wpedantic -Wno-bitwise-instead-of-logical
LDFLAGS     := -I./libs -I./libs/raylib-$(RAYLIB_VER)/include ./libs/raylib-$(RAYLIB_VER)/lib/libraylib.a -lm

game:
	$(CC) $(CFLAGS) -o game main.c $(LDFLAGS)
```

Now we can compile with `make game` and get the following.

![Basic window](/assets/notes/embedding-window.png)

## Converting assets to C header files

Here we use [`xxd`](https://linux.die.net/man/1/xxd) which is used to make a
hexdump or do the reverse. This tool contains an interesting option `-i` which
allows us to output the file in C include file style. And this is exactly what
we need.

Modified `Makefile` now looks like.

```make
RAYLIB_VER  := 5.5_linux_amd64
CC          ?= cc
CFLAGS      := -Wall -Wextra -Wunused -Wno-unused-parameter -Wswitch-enum -Wpedantic -Wno-bitwise-instead-of-logical
LDFLAGS     := -I./libs -I./libs/raylib-$(RAYLIB_VER)/include ./libs/raylib-$(RAYLIB_VER)/lib/libraylib.a -lm

game: embed
	$(CC) $(CFLAGS) -o game main.c $(LDFLAGS)

embed:
	xxd -i data/armor.png > data/armor.h
	xxd -i data/dejavusans-mono.ttf > data/dejavusans-mono.h
```

This converted binary data files into C header style files which contain the
array of bytes and the size of the array of bytes. This will be useful later
with raylib code.

If we execute `make embed` we will create C header files. But running `make
game` will also call embed as well, so no need to call it separately.

An example of such a file (in our case armor.png) looks like this.

```c
// data/armor.h
unsigned char data_armor_png[] = {
    0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x01, 0x40, 0x00, 0x00, 0x01, 0x40,
    0x08, 0x06, 0x00, 0x00, 0x00, 0xcd, 0x90, 0xa5, 0xaa, 0x00, 0x00, 0x00,
    0x01, 0x73, 0x52, 0x47, 0x42, 0x00, 0xae, 0xce, 0x1c, 0xe9, 0x00, 0x00,
    0x00, 0x06, 0x62, 0x4b, 0x47, 0x44, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,
    0xa0, 0xbd, 0xa7, 0x93, 0x00, 0x00, 0x00, 0x09, 0x70, 0x48, 0x59, 0x73,
    0x00, 0x00, 0x17, 0x12, 0x00, 0x00, 0x17, 0x12, 0x01, 0x67, 0x9f, 0xd2,
    0x52, 0x00, 0x00, 0x00, 0x07, 0x74, 0x49, 0x4d, 0x45, 0x07, 0xdc, 0x0c,
    0x1b, 0x07, 0x30, 0x17, 0xb2, 0x1a, 0xee, 0xda, 0x00, 0x00, 0x20, 0x00,
    ...
    0x81, 0x98, 0xa6, 0xb9, 0x2d, 0x37, 0xac, 0x6d, 0x57, 0xb0, 0xed, 0xea,
    0x86, 0xac, 0xa1, 0xa6, 0x6b, 0xf8, 0x54, 0x1f, 0x8e, 0xe3, 0x90, 0xcb,
    0xe6, 0x36, 0x7d, 0x4e, 0x6b, 0xab, 0xcb, 0x78, 0xbd, 0x5e, 0x6c, 0xc7,
    0x01, 0x8f, 0xa7, 0x5e, 0x46, 0x22, 0x37, 0x17, 0x76, 0x13, 0x4d, 0x6c,
    0xab, 0x0c, 0xb0, 0x89, 0x26, 0x9a, 0x68, 0xe2, 0x45, 0xa3, 0x99, 0x2b,
    0x34, 0xd1, 0x44, 0x13, 0xff, 0xb7, 0xf8, 0x27, 0x9b, 0x96, 0x5c, 0x0d,
    0x8b, 0xbb, 0x21, 0xa6, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44,
    0xae, 0x42, 0x60, 0x82
};
unsigned int data_armor_png_len = 118324;
```

## Embedding and compiling

Now it's time to include this files in our `main.c` code and use them. raylib's
API fits perfectly with this style of converting binary files.

```c
#include <stdio.h>
#include "raylib.h"

#include "data/armor.h"
#include "data/dejavusans-mono.h"

#define FONT_SIZE 24

int main(void) {
    SetConfigFlags(FLAG_WINDOW_RESIZABLE | FLAG_VSYNC_HINT | FLAG_WINDOW_HIGHDPI);
    InitWindow(900, 400, "Embedding assets");
    SetTargetFPS(60);

    // Load font from memory.
    Font font = LoadFontFromMemory(".ttf", data_dejavusans_mono_ttf, data_dejavusans_mono_ttf_len, FONT_SIZE, NULL, 0);
    SetTextureFilter(font.texture, TEXTURE_FILTER_TRILINEAR); // Font antialising.

    // Load image from memory and create texture from it.
    Image armor = LoadImageFromMemory(".png", data_armor_png, data_armor_png_len);
    Texture2D armor_texture = LoadTextureFromImage(armor);
    UnloadImage(armor);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(BLACK);

        // Draw the armor texture.
        DrawTexture(armor_texture, 20, 20, WHITE);

        // Draw some text on the screen.
        DrawTextEx(font, "Hello embedded assets.", (Vector2){ 400, 20 }, FONT_SIZE, 0, WHITE);
        DrawTextEx(font, "This is example how we can use embedded fonts.", (Vector2){ 400, 50 }, FONT_SIZE - 4, 0, WHITE);

        EndDrawing();
    }

    UnloadTexture(armor_texture);
    CloseWindow();
    return 0;
}
```

This makes embedding assets quite straightforward. All we need to do is include
header files and then provide byte arrays to the appropriate functions. Like I
said raylib has a bunch of `FromMemory` functions that make this quite easy.

This produces a single binary `game` that includes both assets, so there is no
need to also copy over these assets. Mind you, these binaries can potentially
get quite big and if that is the problem, you could always compile this into a
`so` library and include that. This way you could create data packs for audio,
graphics, etc. and ship that alongside your game binary.

Run `make -B game` and run the game.

![Basic window](/assets/notes/embedding-assets.png)

## Honorable mention: C23-embed-directive

`#embed` is a preprocessor directive to include (binary) resources in the
build, where a resource is defined as a source of data accessible from the
translation environment. This has been introduces with the C23 standard so it's
quite new.

Speaking plainly, `#embed` allows inclusion of binary data in a program
executable image, as arrays of unsigned char or other types, without the need
for an external script run from a Makefile.

- I do like this approach, but some compilers might not support this feature,
  and this is why I will be sticking with manual approach for now.
- One additional drawback is that every time you compile your game, all the
  assets need to be re-read and converted. I have not tested this heavily, but
  this could potentially significantly increase build times when you have a lot
  of assets.
- Not using Make could be detrimental to incremental builds. But this would
  also need to be tested. I do not claim that this is a real problem. Test this
  yourself.

Read more about [Binary resource
inclusion](https://en.cppreference.com/w/c/preprocessor/embed).

Below is a quick example how to use this new directive.

```c
#include <stdint.h>
#include <stdio.h>

const uint8_t image_data[] = {
    #embed "image.png"
};

int main(void) {
    printf("Image size: %d bytes\n", sizeof(image_data));
    return 0;
}
```

## Credits

- https://opengameart.org/content/armor-icons-by-equipment-slot-with-transparency
- https://dejavu-fonts.github.io/
