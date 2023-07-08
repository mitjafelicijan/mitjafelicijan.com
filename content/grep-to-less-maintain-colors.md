---
title: "Grep to Less that maintain colors"
url: grep-to-less-maintain-colors.html
date: 2023-05-29T21:27:07+02:00
type: note
draft: false
tags: [bash]
---

I often use `grep` to search for todo's in my code and other people's code and
then pipe them in `less` and I missed having colors that grep outputs in `less`.

- Grep's `--color=always` use markers to highlight the matching strings.
- Less's `-R` option outputs "raw" control characters.

You could use `alias grep='grep --color=always'` and `alias less='less -R'` or
create todo function in your `.bashrc` that accepts first argument as search
string.

```sh
# This is where the magic happens.
grep --color=always -rni "TODO:" | less -R
```

![Less and grep](/notes/grep-less.png)
