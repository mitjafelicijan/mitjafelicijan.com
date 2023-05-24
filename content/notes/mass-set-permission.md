---
title: Change permissions of matching files recursively
url: mass-set-permission.html
date: 2023-05-16
type: notes
draft: false
---

Replace `*.xml` with your pattern. This will remove executable bit from all
files matching the pattern. Change `+` to `-` to add executable bit.

```sh
find . -type f -name "*.xml" -exec chmod -x {} +
```
