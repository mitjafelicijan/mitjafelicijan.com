---
title: Convert all MKV files into other formats
permalink: /convert-mkv.html
date: 2023-05-14T12:00:00+02:00
layout: post
type: note
draft: false
tags: [ffmpeg]
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

