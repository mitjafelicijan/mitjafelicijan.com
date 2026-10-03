---
title: Minimal set of dotfiles for remote servers
url: tiny-server-dotfiles.html
date: 2026-10-03T16:13:13+02:00
type: note
draft: false
tags: []
---

`~/.tmux.conf`

```txt
set -g default-terminal "screen-256color"
set-window-option -g automatic-rename on
set-window-option -g mode-keys vi
set-option -g set-titles on
set-option -sg escape-time 10
set-option -g mouse off

set -g history-limit 50000
set -g focus-events on

set -g base-index 1
set-window-option -g pane-base-index 1
set -g renumber-windows on
```

`~/.vimrc`

```txt
set nocompatible encoding=utf8 spelllang=en_us laststatus=2 tabstop=4 shiftwidth=4
set number autoindent cursorline ignorecase hlsearch incsearch
set hidden nowrap nobackup noswapfile noundofile autoread background=dark
set completeopt=menu,menuone,noselect

syntax on
filetype plugin on
colorscheme slate

nnoremap <Esc>[1;5C :bnext<CR>
nnoremap <Esc>[1;5D :bprevious<CR>
nnoremap <C-q>      :copen<CR>
nnoremap <Leader>d  :bd!<CR>
nnoremap <Leader>q  :nohlsearch<CR>
```

`~/.bash_aliases`

```txt
alias l='ls -lh --group-directories-first --color=auto'
alias ll='ls -lha --group-directories-first --color=auto'
alias t='tree -L 2'
alias ..='cd ..'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
```
