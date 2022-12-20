---
title: Trying to build a New kind of terminal emulator
url: trying-to-build-a-new-kind-of-terminal-emulator.html
date: 2022-12-20
draft: true
---

```c
// Create the window
SDL_Window *window = SDL_CreateWindow(
  WINDOW_TITLE, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
  WINDOW_WIDTH, WINDOW_HEIGHT,
  SDL_WINDOW_RESIZABLE | SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);
```

Over the past weeks, I have been really thinking about terminal emulators, how we interact with computers, the separation of text-based programs and GUI ones. To be perfectly honest, I got pissed off one evening when I was cleaning up files on my computer. Normally, I go into console and do `ncdu` and check where the junk is. Then I start deleting stuff. Without any discrimination, usually. But when it comes to screenshots, I have learned that it's good to keep them somewhere near if I need to refer to something that I was doing. I am an avid screenshot taker. So at that point I checked Pictures folder and also did a basic search `find . -type f -name "*.jpg"` for all the JPEG files in my home directory and immediately got pissed off. Why can’t I see thumbnails in my terminal? I know why, but why in the year of 2022 this is still a problem. I am used to traversing my disk via terminal. I am faster and I am more comfortable this way. But when it comes to visualization, I then need to revert to GUI applications and again find the same file to see it. I know that programs like `fex` and `sxiv` are available, but I would just like to see the preview. Like [Jupyter notebook](https://jupyter.org/) or something similar. Just having it inline. Part of a result.

It also didn’t help that I was spending some time with the [Plan 9](https://plan9.io/plan9/) Operating system. More specifically [9FRONT](http://9front.org/). The way that [ACME editor](http://acme.cat-v.org/) handles text editing is just wonderful. Different and fresh somehow, even though it’s super old.

So, I went on a lookout for an interesting way of visualizing results of some query. I found these applications to be outstanding examples of how not to be a captive of a predetermined way of doing things.

- [Wolfram Mathematica](https://www.wolfram.com/mathematica/)
- [Jupyter notebooks](https://jupyter.org/)
- [Plan 9 / 9FRONT](http://www.9front.org)
- [Temple OS](https://templeos.org/)
- [Emacs](https://www.gnu.org/software/emacs/)

My idea is not as out there as ACME is, but it is a spin on the terminal emulators. I like the modes that Vi/Vim provides you with. I like the way the Emacs does its own `M-x` `M-c`.  Furthermore, I really like how Mathematica and Jupyter present the data in a free flowing form. And I love how Temple OS is basically a C interpreter on some level.

So I started. I knew that I wanted to have the couple of modes, but I didn’t like the repetition of keystrokes, so the only option was to have some sort of toggle and indicate to the user that they are in a special mode. Like Vi does for Normal and Visual mode.

These modes would for the first version be:

- *Preview mode* (toggle with Ctrl + P)
    - When this mode would be enabled, the `ls` command would try to find images from the results and display thumbnails from them in the terminal itself. No ASCII art. Proper images. In a grid!
- *Detach mode* (toggle with Ctrl + D)
    - When this mode would be enabled, every command would open a new window and execute that command in it. This would be useful for starting `htop` in a separate window.

The reason for having these modes tooglable is to not ask for previews every time. You enable a mode and until you disable it, it behaves that way. Purely out of ergonomic reasons.

I would like to treat every terminal I open as a session mentally. When I start using the terminal, I start digging deeper into the issue I am trying to resolve. And while I am doing this, I would like to open detached windows etc. A lot of these things can be done easily with something like [i3](https://i3wm.org/), but also that pull you out of the context of what you were doing. I would like to orchestrate everything from one single point.

In planning for this project, I knew that I would need to use a language like C and a library such as [SDL2](https://www.libsdl.org/) in order to achieve the desired results. I had considered other options, but ultimately determined that [SDL2](https://www.libsdl.org/) was the best fit based on its capabilities and reputation in the programming community.

At first, I thought the idea of a hardware accelerated terminal was a bit of a joke. It seemed like such a niche and unnecessary feature, especially given the fact that terminal emulators have been around for decades and have always relied on software rendering. But to be fair, [Alacritty](https://alacritty.org/) is doing the same thing.


