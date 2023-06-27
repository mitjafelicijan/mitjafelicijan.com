---
title: Trying to build a New kind of terminal emulator for the modern age
url: trying-to-build-a-new-kind-of-terminal-emulator.html
date: 2023-01-26T12:00:00+02:00
draft: false
---

Over the past few weeks, I have been really thinking about terminal emulators,
how we interact with computers, the separation of text-based programs and GUI
ones. To be perfectly honest, I got pissed off one evening when I was cleaning
up files on my computer. Normally, I go into console and do `ncdu` and check
where the junk is. Then I start deleting stuff. Without any discrimination,
usually. But when it comes to screenshots, I have learned that it's good to keep
them somewhere near if I need to refer to something that I was doing. I am an
avid screenshot taker. So at that point I checked Pictures folder and also did a
basic search `find . -type f -name "*.jpg"` for all the JPEG files in my home
directory and immediately got pissed off. Why can’t I see thumbnails in my
terminal? I know why, but why in the year of 2022 this is still a problem. I am
used to traversing my disk via terminal. I am faster, and I am more comfortable
this way. But when it comes to visualization, I then need to revert to GUI
applications and again find the same file to see it. I know that programs like
`feh` and `sxiv` are available, but I would just like to see the preview. Like
[Jupyter notebook](https://jupyter.org/) or something similar.  Just having it
inline. Part of a result.

It also didn’t help that I was spending some time with the [Plan
9](https://plan9.io/plan9/) Operating system. More specifically
[9FRONT](http://9front.org/). The way that [ACME editor](http://acme.cat-v.org/)
handles text editing is just wonderful. Different and fresh somehow, even though
it’s super old.

So, I went on a lookout for an interesting way of visualizing results of some
query. I found these applications to be outstanding examples of how not to be a
captive of a predetermined way of doing things.

- [Wolfram Mathematica](https://www.wolfram.com/mathematica/)
- [Jupyter notebooks](https://jupyter.org/)
- [Plan 9 / 9FRONT](http://www.9front.org)
- [Temple OS](https://templeos.org/)
- [Emacs](https://www.gnu.org/software/emacs/)

My idea is not as out there as ACME is, but it is a spin on the terminal
emulators. I like the modes that Vi/Vim provides you with. I like the way the
Emacs does its own `M-x` `M-c`.  Furthermore, I really like how Mathematica and
Jupyter present the data in a free flowing form. And I love how Temple OS is
basically a C interpreter on some level.

> **Note:** This is part 1 of the journey. Nowhere finished yet. I am just 
> tinkering with this at the moment. This whole thing can easily spectacularly 
> fail.

So I started. I knew that I wanted to have the couple of modes, but I didn’t
like the repetition of keystrokes, so the only option was to have some sort of
toggle and indicate to the user that they are in a special mode. Like Vi does
for Normal and Visual mode.

These modes would for the first version be:

- *Preview mode* (toggle with Ctrl + P)
    - When this mode would be enabled, the `ls` command would try to find images
    from the results and display thumbnails from them in the terminal itself.
    No ASCII art. Proper images. In a grid!
- *Detach mode* (toggle with Ctrl + D)
    - When this mode would be enabled, every command would open a new window 
    and execute that command in it. This would be useful for starting `htop` 
    in a separate window.

The reason for having these modes togglable is to not ask for previews every
time. You enable a mode and until you disable it, it behaves that way.  Purely
out of ergonomic reasons.

I would like to treat every terminal I open as a session mentally. When I start
using the terminal, I start digging deeper into the issue I am trying to
resolve.  And while I am doing this, I would like to open detached windows
etc. A lot of these things can be done easily with something like
[i3](https://i3wm.org/), but also that pull you out of the context of what you
were doing. I would like to orchestrate everything from one single point.

In planning for this project, I knew that I would need to use a language like C
and a library such as [SDL2](https://www.libsdl.org/) in order to achieve the
desired results. I had considered other options, but ultimately determined that
[SDL2](https://www.libsdl.org/) was the best fit based on its capabilities and
reputation in the programming community.

At first, I thought the idea of a hardware accelerated terminal was a bit of a
joke. It seemed like such a niche and unnecessary feature, especially given the
fact that terminal emulators have been around for decades and have always relied
on software rendering. But to be fair, [Alacritty](https://alacritty.org/) is
doing the same thing. Well, they are doing a remarkable job at it.

So, I embarked on a journey. Everything has to start somewhere. For me, it
started with creating a window! It has to start somewhere. 🙂

```c
// Oh, Hi Mark!
// Create the window, obviously.
SDL_Window *window = SDL_CreateWindow(
  WINDOW_TITLE, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
  WINDOW_WIDTH, WINDOW_HEIGHT,
  SDL_WINDOW_RESIZABLE | SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);
```

I continued like this to get some text displayed on the screen.

I noted that
[`TTF_RenderText_Solid`](https://wiki.libsdl.org/SDL_ttf/TTF_RenderText_Solid)
rendered text really poorly. There were no antialiasing at all. In my wisdom, I
never checked the documentation. Well, that was a fail. To uneducated like me:
`TTF_RenderText_Solid` renders Latin1 text at fast quality to a new 8-bit
surface. So, that's why the texts looked like shit. No wonder.

Remarks on `TTF_RenderText_Solid`: This function will allocate a new 8-bit,
palettized surface. The surface's 0 pixel will be the colorkey, giving a
transparent background. The 1 pixel will be set to the text color.

After I replaced it with
[`TTF_RenderText_LCD`](https://wiki.libsdl.org/SDL_ttf/TTF_RenderText_LCD) which
renders Latin1 text at LCD subpixel quality to a new ARGB surface, the text
started looking good. Really make sure you read the documentation. It’s actually
good. As a side note, you can find all the documentation regarding [SDL2 on
their Wiki](https://wiki.libsdl.org/).

After that was done, I started working on displaying other things like `Preview`
and `Detach` modes. This wasn’t really that hard. In SDL2 you can check all the
available events with `while (SDL_PollEvent(&event) > 0)` and have a bunch of
switch statements to determine which key is currently being pressed. More about
keys, [SDLKey](https://documentation.help/SDL/sdlkey.html) and mroe about
pooling the events on
[SDL_PollEvent](https://documentation.help/SDL/sdlpollevent.html).

```c
while (SDL_PollEvent(&event) > 0)
{
  switch (event.type)
  {
  case SDL_QUIT:
    running = false;
    break;

  case SDL_TEXTINPUT:
    if (!meta_key_pressed)
    {
      strncat(input_prompt_text, event.text.text, 1);
      update_input_prompt = true;
    }
    break;
	}
}
```

After that was somewhat working correctly, I started creating a struct that
would hold all the commands and results and I call them Cells. Yes, I stole that
naming idea from Jupyter.

```c
typedef struct
{
  char *command;
  char *result;
  SDL_Surface *surface;
  SDL_Texture *texture;
  SDL_Rect rect;
} Cell;
```

I am at a place now where I am starting to implement scrolling. This will for
sure be fun to code. Memory management in C is super easy. 😂

I have also added a simple [INI file like
configuration](https://en.wikipedia.org/wiki/INI_file) support. It is done in an
[STB style of
header](https://github.com/nothings/stb/blob/master/docs/stb_howto.txt) and maps
to specific options supported by the terminal. It is not universal, and the code
below demonstrates how I will use it in the future.

```c
#ifndef CONFIG_H
#define CONFIG_H

/*
# This is a comment

# This is the first configuration option
dettach=value11111

# This is the second configuration option
preview=value22222

# This is the third configuration option
debug=value33333
*/

// Define a struct to hold the configuration options
typedef struct
{
    char dettach[256];
    char preview[256];
    char debug[256];
} Config;

// Read the configuration file and return the options as a struct
extern Config read_config_file(const char *filename)
{
  // Create a struct to hold the configuration options
  Config config = {0};

  // Open the configuration file
  FILE *file = fopen(filename, "r");

  // Read each line from the file
  char line[256];
  while (fgets(line, sizeof(line), file))
  {
    // Check if this line is a comment or empty
    if (line[0] == '#' || line[0] == '\n')
      continue;

    // Parse the line to get the option and value
    char option[128], value[128];
    if (sscanf(line, "%[^=]=%s", option, value) != 2)
      continue;

    // Set the value of the appropriate option in the config struct
    if (strcmp(option, "dettach") == 0)
    {
      strncpy(config.option1, value, sizeof(config.option1));
    }
    else if (strcmp(option, "preview") == 0)
    {
      strncpy(config.option2, value, sizeof(config.option2));
    }
    else if (strcmp(option, "debug") == 0)
    {
      strncpy(config.option3, value, sizeof(config.option3));
    }
  }

  // Close the configuration file
  fclose(file);

  // Return the configuration options
  return config;
}

#endif
```

This is as far as I managed to get for now. I have a daily job and this
prohibits me to work on these things full time. But I should probably get back
and finish this. At least have a simple version working out, so I can start
testing it on my machines. Fingers crossed. 🕵️‍♂️

