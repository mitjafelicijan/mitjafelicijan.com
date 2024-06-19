---
title: "Personal sane Vim defaults"
url: apersonal-sane-vim-defaults.html
date: 2023-11-07T01:04:28+02:00
type: note
draft: false
tags: [vim]
---

I have found many "sane" default configs on the net and this is my favorite
personal list. This is how my `.vimrc` file looks like.

```vimrc
" General sane defaults.
syntax enable
colorscheme sorbet
nnoremap q: <nop>
set nocompatible
set relativenumber
set nohlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set nowrap
set nobackup
set noswapfile
set autoread
set wildmenu
set encoding=utf8
set backspace=2
set scrolloff=4
set spelllang=en_us

" Status Line enhancements.
set laststatus=2
set statusline=%f%m%=%y\ %{strlen(&fenc)?&fenc:'none'}\ %l:%c\ %L\ %P
hi StatusLine cterm=NONE ctermbg=black ctermfg=brown
hi StatusLineNC cterm=NONE ctermbg=black ctermfg=darkgray

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

" Language specific indentation.
filetype plugin indent on
autocmd Filetype make,go,c,cpp setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype html,js,css setlocal expandtab tabstop=2 shiftwidth=2
```

I keep it pretty vanilla so this is about everything I have in the file.

