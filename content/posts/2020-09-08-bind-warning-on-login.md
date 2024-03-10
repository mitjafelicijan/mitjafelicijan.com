---
title: Fix bind warning in .profile on login in Ubuntu
url: bind-warning-on-login-in-ubuntu.html
date: 2020-09-08T12:00:00+02:00
type: post
draft: false
---

Recently I moved back to [bash](https://www.gnu.org/software/bash/) as my
default shell. I was previously using [fish](https://fishshell.com/) and got
used to the cool features it has. But, regardless of that, I wanted to move to a
more standard shell because I was hopping back and forth with exporting
variables and stuff like that which got pretty annoying.

So I embarked on a mission to make [bash](https://www.gnu.org/software/bash/)
more like [fish](https://fishshell.com/) and in the process found that I really
missed autosuggest with TAB on changing directories.

I found a nice alternative that emulates [zsh](http://zsh.sourceforge.net/) like
autosuggestion and autocomplete so I added the following to my `.bashrc` file.

```bash
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind '"\e[Z":menu-complete-backward'
```

I haven't noticed anything wrong with this and all was working fine until I
restarted my machine and then I got this error.

![Profile bind error](/assets/posts/profile-bind-error/error.jpg)

When I pressed OK, I got into the [Gnome
shell](https://wiki.gnome.org/Projects/GnomeShell) and all was working fine, but
the error was still bugging me. I started looking for the reason why this is
happening and found a solution to this error on [Remote SSH Commands - bash bind
warning: line editing not enabled](https://superuser.com/a/892682).

So I added a simple `if [ -t 1 ]` around `bind` statements to avoid running
commands that presume the session is interactive when it isn't.

```bash
if [ -t 1 ]; then
  bind "TAB:menu-complete"
  bind "set show-all-if-ambiguous on"
  bind "set completion-ignore-case on"
  bind "set menu-complete-display-prefix on"
  bind '"\e[Z":menu-complete-backward'
fi
```

After logging out and back in the problem was gone.
