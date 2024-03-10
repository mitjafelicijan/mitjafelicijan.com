---
title: "Alacritty open links with modifier"
url: alacritty-open-links-with-modifier.html
date: 2023-06-25T17:17:16+02:00
type: note
draft: false
---

Alacritty by default makes all links in the terminal output clickable and this
gets annoying rather quickly. I liked the default behavior of Gnome terminal
where you needed to hold Control key and then you could click and open links.

To achieve this in Alacritty you need to provide a `hint` in the configuration
file. Config file is located at `~/.config/alacritty/alacritty.yml`.

```yaml
hints:
  enabled:
  - regex: "(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)\
            [^\u0000-\u001F\u007F-\u009F<>\"\\s{-}\\^⟨⟩`]+"
    command: xdg-open
    post_processing: true
    mouse:
      enabled: true
      mods: Control
```

The following should work under any Linux system. For macOS, you will need to
change `command: xdg-open` to something else.

Now the links will be visible and clickable only when Control key is being
pressed.

Source: https://github.com/alacritty/alacritty/issues/5246
