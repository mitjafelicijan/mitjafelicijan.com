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
" General sane defaults.
syntax enable
colorscheme sorbet
set nocompatible
set relativenumber
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set nowrap
set nobackup
set autoread
set noswapfile
set wildmenu
set encoding=utf8
set backspace=2
set tabstop=2
set shiftwidth=2
set expandtab
set autoread
set scrolloff=4

" Format current paragraph to 80 rows.
noremap <C-f> vipgq

" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,go,scala   let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType lua              let b:comment_leader = '-- '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Status Line enhancements.
set laststatus=2

hi User1 ctermfg=green  ctermbg=black
hi User2 ctermfg=yellow ctermbg=black
hi User3 ctermfg=red    ctermbg=black
hi User4 ctermfg=blue   ctermbg=black
hi User5 ctermfg=white  ctermbg=black

set statusline=
set statusline +=%1*\ %n\ %*    "buffer number
set statusline +=%5*%{&ff}%*    "file format
set statusline +=%3*%y%*        "file type
set statusline +=%4*\ %<%F%*    "full path
set statusline +=%2*%m%*        "modified flag
set statusline +=%1*%=%5l%*     "current line
set statusline +=%2*/%L%*       "total lines
set statusline +=%1*%4v\ %*     "virtual column number
set statusline +=%2*0x%04B\ %*  "character under cursor
```

I keep it pretty vanilla so this is about everything I have in the file.

