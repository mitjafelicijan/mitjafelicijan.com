---
title: "Extending dte editor"
url: /extending-dte-editor.html
date: 2023-05-31T08:12:45+02:00
type: note
draft: false
---

[`dte`](https://craigbarnes.gitlab.io/dte/) is an interesting editor I started
using lately more and more. Since it is using
[`execvp()`](https://linux.die.net/man/3/execvp) it can be easily extended. I
needed comment/uncomment feature so I created a small utility that does this for
me. Code lives on repository [dte
extensions](https://git.mitjafelicijan.com/dte-extensions.git/about/) but this
utilities can be used for whatever you want. Make sure you have version 1.11 or
above.

Next one will be invoking formatter based on the type of a file.

My config that works for me.

```sh
set show-line-numbers true;
set tab-width 4;
set case-sensitive-search false;

# Special aliases
alias m_comment 'exec -s -i line -o buffer -e errmsg ~/.dte/bin/comment'
alias m_format 'save; exec go fmt .; reload'
alias m_duplicate 'copy;paste';

# Useful aliases.
alias m_force_close 'quit -f';
alias m_reload 'close; open $FILE'

# Key bindings.
bind M-s save;
bind M-q m_force_close;
bind M-z refresh;
bind C-down blkdown;
bind C-up blkup;
bind C-_ m_comment;
bind M-. m_format;
bind C-d m_duplicate;

# Syntax highlighting.
hi preproc magenta;
hi keyword red;
hi linenumber blue;
hi comment cyan;
```
