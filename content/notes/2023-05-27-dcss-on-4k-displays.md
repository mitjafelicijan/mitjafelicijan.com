---
title: "Make DCSS playable on 4k displays"
url: /dcss-on-4k-display.html
date: 2023-05-27T19:35:11+02:00
type: note
draft: false
---

Dungeon Crawl Stone Soup has a a very small font by default. On a 4k display, it
is barely readable. This is how I made it playable.

Make a file `~/.crawlrc` with the following content:

```ini
# Adjust the sizes to your liking.

tile_font_crt_size = 32
tile_font_stat_size = 32
tile_font_msg_size = 32
tile_font_tip_size = 32
tile_font_lbl_size = 32
tile_sidebar_pixels = 64
```

To zoom in and out in viewport, press `Ctrl+` and `Ctrl-` respectively.

All the possible options are documented in the [Dungeon Crawl Stone Soup Options
Guide](https://github.com/crawl/crawl/blob/master/crawl-ref/docs/options_guide.txt)
file.
