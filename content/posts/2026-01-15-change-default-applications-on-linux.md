---
title: Change default applications on Linux from terminal
url: change-default-applications-on-linux-from-terminal.html
date: 2026-01-15T16:13:13+02:00
type: post
draft: false
tags: []
---

Changing default applications is done with command `xdg-mime`. This is a
command line tool for querying information about file type handling and adding
descriptions for new file types. Make sure you have this program installed.

Application will use `.desktop` files to associate applications with specific
types.

## Location and structure of `.desktop` files

```sh
ls /usr/share/applications
ls ~/.local/share/applications
```

You can add your own `.desktop` files to `~/.local/share/applications`.

An example of `.desktop` file for Brave browser located in
`~/.local/share/applications/brave.desktop`.

```ini
[Desktop Entry]
Exec=/home/m/Applications/brave
Type=Application
Categories=Applications
Name=Brave Browser
```

## Query current associations

You can query specific types with `xdg-mime`.

```sh
xdg-mime query default text/plain
xdg-mime query default text/html
xdg-mime query default x-scheme-handler/http
xdg-mime query default x-scheme-handler/https
xdg-mime query default inode/directory
```

Or you can look at the files containing this data.

```sh
less ~/.config/mimeapps.list
less /usr/share/applications/mimeapps.list
```

## Set default application

```sh
# Set Brave as default browser.
xdg-mime default brave.desktop x-scheme-handler/http
xdg-mime default brave.desktop x-scheme-handler/https

# Set Thunar as default file explorer.
xdg-mime default thunar.desktop inode/directory

# Set Mousepad as default txt editor.
xdg-mime default mousepad.desktop text/plain
```

## Interfacing with C

This simple example lists all registered types. But you can see where this can
go. This could be turned into ncurses CLI application that is used for setting
and changing default applications.

```c
#include <gio/gio.h>

int main(void) {
    GList *types = g_content_types_get_registered();

    for (GList *l=types; l!=NULL; l=l->next) {
        g_print("%s\n", (char *)l->data);
    }

    g_list_free_full(types, g_free);
    return 0;
}
```

Compile with `clang -o main main.c $(pkg-config --cflags --libs gio-2.0)`.

## Reading material

- https://wiki.archlinux.org/title/XDG_MIME_Applications
- https://commandmasters.com/commands/xdg-mime-linux/
- https://noman.sh/en/pages/xdg-mime
- https://linux.die.net/man/1/xdg-mime
- https://wiki.archlinux.org/title/XDG_MIME_Applications
- https://gnome.pages.gitlab.gnome.org/libsoup/gio/
- https://docs.gtk.org/gio/
