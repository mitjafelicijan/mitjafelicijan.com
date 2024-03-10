---
title: "Using ffmpeg to combine videos side by side"
url: /using-ffmpeg-to-combine-video-side-by-side.html
date: 2023-11-04T09:04:28+02:00
type: note
draft: false
---

I had a 4 webm videos (each 492x451) that I wanted to combine to be played side
by side and I tried [iMovie](https://support.apple.com/imovie) and
[Kdenlive](https://kdenlive.org/) and failed to do it in an easy way. I needed
this for Github readme file so it also needed to be a GIF.

The following is the [ffmpeg](https://ffmpeg.org/) version of it.

```sh
ffmpeg -y \
  -i 01.webm \
  -i 02.webm \
  -i 03.webm \
  -i 04.webm \
  -filter_complex "\
  	[0:v] trim=duration=8, setpts=PTS-STARTPTS, scale=492x451, fps=6 [a0]; \
  	[1:v] trim=duration=8, setpts=PTS-STARTPTS, scale=492x451, fps=6 [a1]; \
  	[2:v] trim=duration=8, setpts=PTS-STARTPTS, scale=492x451, fps=6 [a2]; \
  	[3:v] trim=duration=8, setpts=PTS-STARTPTS, scale=492x451, fps=6 [a3]; \
  	[a0][a1][a2][a3] xstack=inputs=4:layout=0_0|w0_0|w0+w1_0|w0+w1+w2_0, scale=1000:-1 [v]" \
  -map "[v]" \
  -crf 23 \
  -preset veryfast \
  trigraphs.gif
```

- This will produce `trigraphs.gif` that is also scaled to max 1000px in width
  (refer to `scale=1000:-1`).
- The important part for 4x1 stack is `xstack=inputs=4:layout=0_0|w0_0|w0+w1_0|w0+w1+w2_0`.
- This will also cap frame rate to 6 (refer to `fps=6`) since that is enough and
  this makes playback of GIFs smoother in a browser.

![Result](./assets/notes/trigraphs.gif)
