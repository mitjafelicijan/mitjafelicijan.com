---
title: Push to multiple origins at once in Git
url: git-push-multiple-origins.html
date: 2023-05-06
type: notes
draft: false
tags: [git]
---

Sometimes you want to push to multiple origins at once. This is useful if you
have a mirror of your repository on another server. You can do this by adding
multiple push urls to your git config. This is a shorthand for command above.

```sh
git config --global alias.pushall '!sh -c "git remote | xargs -L1 git push --all"'
```
