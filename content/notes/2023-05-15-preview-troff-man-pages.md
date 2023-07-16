---
title: Previews how man page written in Troff will look like
url: preview-troff-man-pages.html
date: 2023-05-15T12:00:00+02:00
type: note
draft: false
tags: [troff]
---

Troff is used to write man pages and it is difficult to read it so this will
preview how it will look like when it is rendered.

```sh
# On Linux system.
groff -man -Tascii filename

# On Plan9 system.
man 1 filename
```

