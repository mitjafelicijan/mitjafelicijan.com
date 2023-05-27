---
title: Take a screenshot in Plan9
url: plan9-screenshot.html
date: 2023-05-10T12:00:00+02:00
type: notes
draft: false
tags: [plan9]
---

Take a screenshot in Plan9. This applies to [Plan9](https://9p.io/plan9/) and
[9front](https://9front.org/). This will take a screenshot of the screen and
output it to `/dev/screen`. You can then use `topng` to convert it to a png
image.

```sh
# Instant screenshot.
cat /dev/screen | topng > screen.png

# Delayed screenshot (5 seconds).
sleep 5; cat /dev/screen | topng > screen.png
```

