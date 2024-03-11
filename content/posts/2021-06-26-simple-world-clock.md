---
title: Simple world clock with eInk display and Raspberry Pi Zero
url: simple-world-clock-with-eiink-display-and-raspberry-pi-zero.html
date: 2021-06-26T12:00:00+02:00
type: post
draft: false
---

Our team is spread across the world, from the USA all the way to Australia, so
having some sort of world clock makes sense.

Currently, I am using an extension for Gnome called [Timezone
extension](https://extensions.gnome.org/extension/2657/timezones-extension/),
and it serves the purpose quite well.

But I also have a bunch of electronics that I bought through the time, and I am
not using any of them, and it's time to stop hording this stuff and use it in a
project.

A while ago I bought a small eInk display [Inky
pHAT](https://shop.pimoroni.com/products/inky-phat?variant=12549254217811) and I
have a bunch of [Raspberry Pi's
Zero](https://www.raspberrypi.org/products/raspberry-pi-zero/) lying around that
I really need to use.

![Inky pHAT, Raspberry Pi Zero](/assets/posts/world-clock/hardware.jpg)

Since the Inky [Inky
pHAT](https://shop.pimoroni.com/products/inky-phat?variant=12549254217811) is
essentially a HAT, it can easily be added on top of the [Raspberry Pi
Zero](https://www.raspberrypi.org/products/raspberry-pi-zero/).

First, I installed the necessary software on Raspberry Pi with `pip3 install
inky`.

And then I created a file `clock.py` in home directory `/home/pi`.

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
from inky.auto import auto
from PIL import Image, ImageFont, ImageDraw
from font_fredoka_one import FredokaOne

clocks = [
  'America/New_York',
  'Europe/Ljubljana',
  'Australia/Brisbane',
]

board = auto()
board.set_border(board.WHITE)
board.rotation = 90

img = Image.new('P', (board.WIDTH, board.HEIGHT))
draw = ImageDraw.Draw(img)

big_font = ImageFont.truetype(FredokaOne, 18)
small_font = ImageFont.truetype(FredokaOne, 13)

x = board.WIDTH / 3
y = board.HEIGHT / 3

idx = 1
for clock in clocks:
  ctime = os.popen('TZ="{}" date +"%a,%H:%M"'.format(clock))
  ctime = ctime.read().strip().split(',')
  city = clock.split('/')[1].replace('_', ' ')

  draw.text((15, (idx*y)-y+10), city, fill=board.BLACK, font=small_font)
  draw.text((110, (idx*y)-y+7), str(ctime[0]), fill=board.BLACK, font=big_font)
  draw.text((155, (idx*y)-y+7), str(ctime[1]), fill=board.BLACK, font=big_font)

  idx += 1

board.set_image(img)
board.show()
```

And because eInk displays are rather slow to refresh and the clock requires
refreshing only once a minute, this can be done through cronjob.

Before we add this job to cron we need to make `clock.py` executable with `chmod
+x clock.py`.

Then we add a cronjob with `crontab -e`.

```txt
* * * * * /home/pi/clock.py
```

So, we end up with a result like this.

![World Clock](/assets/posts/world-clock/world-clock.jpg)

You can download my [STL file for the enclosure
here](/assets/posts/world-clock/enclosure.stl), but make sure that dimensions make
sense and also opening for USB port should be added or just use a drill and some
hot glue to make it stick in the enclosure.
