---
title: "Configuration and plugin hell and why I don't use Vim and Tmux anymore"
url: configuration-and-plugin-hell-and-why-i-dont-use-vim-and-tmux-anymore.html
date: 2024-03-14T11:11:20+01:00
type: post
draft: false
---

There are three tiers of CLI software as far as I am concerned:

- tools like `ls`, `cat`, `ps` (you use flags to customize, and you pipe
results through them),
- tools like `htop`, `nvtop`, `midnight commander`
(you can change the theme and maybe small things),
- editors like `vim`,
`helix`, `emacs` and multiplexers like `tmux`, `zellij`, `screen`
(usually very customizable).

I understand that something like [GNU
utils](https://www.gnu.org/software/coreutils/) need to be small and
concise and minimal. No unnecessary fat or configuration options. I am a
massive proponent of [POSIX](https://en.wikipedia.org/wiki/POSIX)
style of utilities. I still think the [`pipe
operator`](https://www.geeksforgeeks.org/piping-in-unix-or-linux/) is
one of the most amazing things every invented. I am still in awe when
I use it today.

But when it comes to applications like text editors or terminal
multiplexers, I have a bit of a different opinion. I think they need to
have some basic batteries included. And I agree that basic batteries
included is a loaded term and means different things to different
people. I will try to make a case that takes in account things that
matter to me and, by extension, also matter to others. Otherwise, they
would not have configuration files for these applications that are bigger
than some of their own projects.

It is very naive to think that bare-bones [Vim](https://www.vim.org/)
is enough for working on a larger codebase. For some it may
be so, but the majority of people would prefer some minimal
[LSP](https://en.wikipedia.org/wiki/Language_Server_Protocol) integration
to quickly jump to definitions, fuzzy finding of files, things like
that. And in [Vim](https://www.vim.org/), I need a plugin to do this. The
same goes for [Neovim](https://neovim.io/).

People bash on others when they say: I would rather not deal with
configurations, or I just want to use my system without the time
investment of learning everything into details and then configuring it.

Most people don't derive their pleasure from ricing their setup. How is
this so impossible to understand for some people?

There is also the argument that you should learn your tools. That is
correct and true. But again, it's a matter of perspective. Not everything
needs to be conquered and dominated. I am perfectly fine with knowing only
30% of some tool if 30% is what I need from it to do the job I need to do.

For me, the argument, "But what if you end up being on a
server?" is ridiculous. Firstly, you shouldn't be developing on
a server. If you need to SSH to debug something, there is probably
[Vi](https://en.wikipedia.org/wiki/Vi_%28text_editor%29) there already and
`:w` and searching config files will work. And if nothing else, you most
likely have `nano`. Not pretty, but gets the job done. I don't think
people making these arguments take their [Neovim](https://neovim.io/)
setup (with all their custom shortcuts and plugins, which makes this
a [PDE](https://www.guidefari.com/pde/) actually) with them on the
server. If they do this, they should be fired. :)

You should learn [Vim motions](https://vim.rtorr.com/) is another
one. They will change your life. I did learn a lot of them. I think
they are amazing. But my life wasn't changed at all. I can still
hop into a normal notepad and do some coding there and be very
productive. Nothing really changed for me. I suspect these are the
things that people who have a very addictive personalities say because
[Vim](https://www.vim.org/) motions bring joy to them. I can imagine
they get a massive dopamine hit using it. For me, it does nothing. It
is a convenient way to edit text. If I don't have them, I also don't
miss them. [Vim motions](https://vim.rtorr.com/) I mean. I adapt
quickly. Doesn't bother me at all.

The next argument I hear a lot is, "I only check my setup once a year, and
then I am set. I don't tinker with my setup at all". This is an argument
of a seasoned user who went through all the stages of Vimtopia. If you
were to put a vanilla Vim in front of them, they would feel almost as lost
as a first-time user. You get a completely warped sense of reality when
you rice your setup to ungodly levels. Which you tend to do anyway. It's
the nature of the beast. Sure, you would know some basic motions, but
all those custom shortcuts you are so used to would not be there. You
would feel lost. No question about it.

Did I have a massive `.vimrc`? Yes, I did. I was transitioning
from [Emacs](https://www.gnu.org/software/emacs/) to
[Vim](https://www.vim.org/) and I wanted some basic things to navigate
code and not waste time finding stuff in projects I work on. And
to reproduce something usable required multiple plugins to make
[LSP](https://en.wikipedia.org/wiki/Language_Server_Protocol) work,
fuzzy searching was a bit easier, just two plugins, I think. But
it required a ton of reading and Googling for information. Also,
let's not pretend these plugins are frozen in time. Making
[LSP](https://en.wikipedia.org/wiki/Language_Server_Protocol) work with
[Neovim](https://neovim.io/) became much easier, and you now use different
plugins than you did two years ago. So, you also have to keep track of
these things. This adds a big overhead. Let's be honest about it.

The same goes for [Tmux](https://github.com/tmux/tmux). Tmux also supports
plugins. And here we go again. And saying you can just use the native
functionalities is a dishonest thing to say. Because if that were true,
nobody would use these plugins, and they would not be popular at all.

Now, if you like ricing your setup. Configuring things. And playing
around with your environment, you go for it. I can understand. I was
the same in my youth. It was fun and I loved every minute of it.

The problematic thing that occurs is that Vim evangelists them go and
preach the Vim gospel, making everybody not using it feel like shit and
incompetent fools who do not care about "real" programming.

I have friends who use [VS Code](https://code.visualstudio.com/) and
are amazing programmers. They don't care about terminals or plugins or
config files. They open their editor of choice and smash at writing the
code they need to write. And my respect for them has nothing to do with
the complexity of their setup. I respect them because the code they write
is of high quality. How they come up with it is of no importance to me.

Most of the software we use daily or runs our world was written by
people who barely knew how to use a keyboard. Just watch [Brian Kernighan
type](https://www.youtube.com/watch?v=tc4ROCJYbm0) and you will see what
I mean. And then look at his accomplishments. Slow typing doesn't mean
shit. It's the quality of the work that matters.

The reason why I switched to
[Helix](https://helix-editor.com/) is simple. It has
[LSP](https://en.wikipedia.org/wiki/Language_Server_Protocol) and fuzzy
finding built-in. There is no plugin system in place, so they needed to
include common things programmers need these days. For commenting a line,
you don't need a plugin. Just press `ctrl+c` over the line and that's
it. I don't remap anything. I use the defaults. The only thing I did
was change a default theme. And I choose one that is bundled with the
editor. That was it!

The same goes for [Tmux](https://github.com/tmux/tmux). I
don't use it anymore, but I need a multiplexer. I am used to
it. Old dog, new tricks kind of a thing. I've used it for years
and years. And [Zellij](https://zellij.dev/) is a modern take on
[Tmux](https://github.com/tmux/tmux). Batteries included and with sane
defaults. No config file or plugins on my system to make it usable.

This elitism about personal setups is so exhausting. You should use
your computer the way you want to use it, and I will use my the way I
see fit. This herd mentality I see so often is so cringe. I'm so over
taking people seriously when it comes to these topics.
