---
title: "Sane default for Dungeon Crawl Stone Soup Online edition"
url: dcss-online-rc-defaults.html
date: 2024-02-21T06:35:11+02:00
type: note
draft: false
tags: [dcss]
---

I mostly play Dungeon Crawl Stone Soup online on Ohio, USA: cbro.berotato.org server and
when you start playing you can select the version you want to play. Each instance also
has `rc` file that can customize the way the game behave.

This is my sane defaults config. It zooms in the game without needing to zoom in the
browser and it also adds a bit of delays in exploring and it stops at fight.

```ini
autofight_stop = 80
explore_auto_rest = true
explore_delay = 20
default_manual_training = true
travel_open_doors = false

tile_cell_pixels = 64
tile_font_crt_size = 32
tile_font_stat_size = 32
tile_font_msg_size = 32
tile_font_tip_size = 32
tile_font_lbl_size = 32
tile_map_pixels = 0
tile_filter_scaling = false
```

All the possible options are documented in the [Dungeon Crawl Stone Soup Options
Guide](https://github.com/crawl/crawl/blob/master/crawl-ref/docs/options_guide.txt)
file.
