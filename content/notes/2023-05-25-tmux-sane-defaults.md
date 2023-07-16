---
title: Sane defaults for tmux with more visible statusbar
url: tmux-sane-defaults.html
date: 2023-05-25T12:00:00+02:00
type: note
draft: false
tags: [tmux]
---

```conf
# Remap prefix from 'C-b' to 'M-a'.
unbind C-b
set-option -g prefix M-a
bind-key M-a send-prefix

# Split panes using | and -.
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Start counting windows with 1.
set-option -g allow-rename on
set -g base-index 1
setw -g pane-base-index 1

# Statusbar: purple bg and white fg.
set -g status-bg '#480b8e'
set -g status-fg '#ffffff'

# Active window: black bg and white fg. 
set -g window-status-current-format "#[fg=#ffffff]#[bg=#111111]#[fg=#ffffff]#[bg=#111111] #I:#W #[fg=#ffffff]#[bg=#111111]"

# Disable mouse mode (tmux 2.1 and above).
set -g mouse off
```

