---
title: Download list of YouTube files
url: download-youtube-videos.html
date: 2023-05-13T12:00:00+02:00
type: note
draft: false
tags: [youtube]
---

If you need to download a list of YouTube videos and don't want to download the
actual YouTube list (which `yt-dlp` supports), you can use the following method.

```js
// Used to get list of raw URL's from YouTube's video tab'.
// Copy them into videos.txt.
document.querySelectorAll('#contents a.ytd-thumbnail.style-scope.ytd-thumbnail').forEach(el => console.log(el.href))
```

Download and install https://github.com/yt-dlp/yt-dlp.

```sh
# This will download all videos in videos.txt.
yt-dlp --batch-file videos.txt -N `nproc` -f webm
```

