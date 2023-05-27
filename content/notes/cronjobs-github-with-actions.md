---
title: "Cronjobs on Github with Github Actions"
url: cronjobs-github-with-actions.html
date: 2023-05-27T00:35:36+02:00
type: notes
draft: false
tags: [github]
---

In the root of your repository create a folder `.github/workflows` and
in that folder create a file a file `cron.yaml`. This file can be named
whatever you wish. But it has to be a `yaml` file.

File below (`.github/workflows/cron.yaml`) describes an action that will
trigger every six hours and it will curl example.com.

However. Be sure that you have enough credits. Free account is not that
generous with the minutes they give you for free. Check more about
GitHub Actions usage on their website https://docs.github.com/en/actions.


```yaml
# .github/workflows/cron.yaml
name: Do a curl every 6 hours
on:
  schedule:
    - cron: '0 */6 * * *'
jobs:
  cron:
    runs-on: ubuntu-latest
    steps:
      - name: Call some url
        run: curl 'https://example.com'
```
