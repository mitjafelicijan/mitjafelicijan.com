---
title: From General Zod to Superman - Crafting Stories in Zed Editor
url: crafting-stories-in-zed-editor.html
date: 2023-05-22T12:00:00+02:00
draft: false
---

Pretentious title! Good start! I have nothing to add to this discussion. I just
like this editor and wanted to write something here that will remind me to use
it again in a while when/if it becomes available for Linux.

**TLDR:** I think this code editor is very cool and has a massive potential.  I
hope they don’t mess up with adding a plugin ecosystem to it!

Out of morbid curiosity, I started using the [Zed editor](https://zed.dev/) on
my Mac. Zed is a high-performance, multiplayer code editor developed by the
creators of Atom and Tree-sitter. Written in Rust so it has to be blazingly
fast! 😊 It's a joke, calm down.

Over the past year, I have switched between [Helix
editor](https://helix-editor.com/) and [VS
Code](https://code.visualstudio.com/), but for the last couple of months, I have
been using Helix exclusively.

I've been genuinely impressed by Zed. When you open a file, it automatically
detects its type and downloads the corresponding [LSP (language
server)](https://en.wikipedia.org/wiki/Language_Server_Protocol).  The list of
supported languages is not extensive, but it's still impressive.  It's a great
example of how to create a product that stays out of your way.

![Zed editor](/assets/zed/zed-1.png?style=bigimg)

For C development it downloaded [clangd](https://clangd.llvm.org/) and setting
up missing dependencies in code was rather easy. For this project I use
[SDL2](https://www.libsdl.org/) for rendering terminal emulator. It’s a hobby
project, don’t worry about it.

If you are going to give this a try and you are using C, I suggest checking two
files in the root of your project folder. If you don't have them, create them.

**compile_flags.txt**

```
-I/opt/homebrew/include
-I/opt/homebrew/include/SDL2
```

Easy way of checking what the appropriate includes for a specific library is to
use `pkg-config` and in my case `pkg-config SDL2 --cflags-only-I`. But this is
nothing new to C/C++ devs. Just a noter for people who are using Visual Studio.

**.clang-format**

```
ColumnLimit: 220
BasedOnStyle: Mozilla
```

I prefer Mozilla coding style for C so you can set that up.

They really have something special here. Although there is no version available
for Linux yet, I will stick to Helix. This impressive piece of engineering is,
above all, an amazing example of craftsmanship.

They have a bunch of amazing integrated functionalities like live desktop
sharing, code sharing in a live coding session. There is a lot of pretentious
marketing speak there but the product is still amazing!

For me the speed and the simplicity of the product was the most impressive 
thing. You get that: it just works feeling. A rare thing in 2023.

![Zed editor](/assets/zed/zed-2.png?style=bigimg)

They also managed to add [Github Copilot](https://github.com/features/copilot)
in a non obtrusive way. To me, everything feels very intentional and
specifically selected. It's minimal yet maximally effective.

<video src="https://zed.dev/img/post/copilot/copilot-demo.webm" autoplay loop></video>

It is a perfect balance between VS Code, Jetbrains IDE’s and something like VIM
or Helix.

I just hope they **DON’T** add plugin support and keep it like it is. They as a
vendor should add stuff to it with great deliberation and thought. And this way
the product will stay fast and focused. That’s my two cents.

Amazing job!
