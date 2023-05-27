---
title: "Drawing Pixels in Plan9"
url: drawing-pixels-in-plan9.html
date: 2023-05-27T17:41:33+02:00
type: notes
draft: false
tags: [plan9, graphics]
---

I have started exploring Plan9's graphics capabilities. This is a hello world
alternative for drawing that draws a yellow square on a red background.

More information:

- [draw.h header file](https://github.com/0intro/plan9/blob/main/sys/include/draw.h)
  contains all the drawing functions
- [draw man page](https://9fans.github.io/plan9port/man/man3/graphics.html)
  has a bit more digestable descriptions of the functions
- [all man pages](https://9fans.github.io/plan9port/man/man3/)
  can be a valuable resource for learning about the system

![Plan9 Howdy World!](/notes/plan9-pixels.png)

```c
// main.c
#include <u.h>
#include <libc.h>
#include <draw.h>
#include <cursor.h>

void main(int argc, char *argv[])
{
  ulong co;
  Image *im, *bg;
  co = 0xFF0000FF;

  if (initdraw(nil, nil, argv0) < 0)
  {
    sysfatal("%s: %r", argv0);
  }

  im = allocimage(display, Rect(0, 0, 100, 100), RGB24, 0, DYellow);
  bg = allocimage(display, Rect(0, 0, 1, 1), RGB24, 1, co);

  if (im1 == nil || bg == nil)
  {
    sysfatal("get more memory, bub");
  }

  draw(screen, screen->r, bg, nil, ZP);
  draw(screen, screen->r, im, nil, Pt(-40, -40));

  flushimage(display, Refnone);

  // Wait 10 seconds before exiting.
  sleep(10000);

  exits(nil);
}
```

And then compile with `mk` (mkfile below):

```makefile
# mkfile
</$objtype/mkfile

RC=/rc/bin
BIN=/$objtype/bin
MAN=/sys/man

main:
	$CC $CFLAGS main.c
	$LD $LDFLAGS -o main main.$O
```

And run with `./main`. To exit the program, press `Delete key` (strange but this
is the alternative for Ctrl+C).

*This is **very cool** indeed!*
