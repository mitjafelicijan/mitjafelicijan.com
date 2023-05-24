---
title: Convert all MKV files into other formats
url: convert-mkv.html
date: 2023-05-14
type: notes
draft: false
tags: [ffmpeg, mkv, webm, mp4]
---

You will need `ffmpeg` installed on your system. This will convert all MKV files
into WebM format.

```sh
# Convert all MKV files into WebM format.
find ./ -name '*.mkv' -exec bash -c 'ffmpeg -i "$0" -vcodec libvpx -acodec libvorbis -cpu-used 5 -threads 8 "${0%%.mp4}.webm"' {} \;
```

```sh
# Convert all MKV files into MP4 format.
find ./ -name '*.mkv' -exec bash -c 'ffmpeg -i "$0" c:a copy -c:v copy -cpu-used 5 -threads 8 "${0%%.mp4}.mp4"' {} \;
```
