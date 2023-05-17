---
title: Push to multiple origins at once in Git
url: push-to-multiple-origins-at-once-in-git.html
date: 2023-05-10
draft: false
---

This is a quick one. I use my personal Git server as my main server, and I use GitHub only as a mirror. As a result, I constantly forget to push to GitHub.

To push to multiple origins at once in Git, you can create a custom Git alias or use a script to automate the process. Here's an example of how you can achieve this using a Git alias:

```sh
git config --global alias.pushall '!sh -c "git remote | xargs -L1 git push --all"'
```

This command creates a Git alias called `pushall` which, when executed, will push the changes to all the remote repositories associated with the current repository. To use it, simply run `git pushall` instead of `git push` when you want to push to all the remote repositories at once.

That's all, folks.
