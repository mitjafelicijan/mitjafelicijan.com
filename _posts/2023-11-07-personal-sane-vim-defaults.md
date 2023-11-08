---
title: "Personal sane Vim defaults"
permalink: /apersonal-sane-vim-defaults.html
date: 2023-11-07T01:04:28+02:00
layout: post
type: note
draft: false
---

I have found many "sane" default configs on the net and this is my favorite
personal list. This is how my `.vimrc` file looks like.

```vimrc
syntax enable
colorscheme sorbet

set nocompatible
set relativenumber
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoread
set autoindent
set nowrap
set noswapfile
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set autoread
set scrolloff=4

noremap <C-f> vipgq

" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
```

I keep it pretty vanilla so this is about everything I have in the file.

