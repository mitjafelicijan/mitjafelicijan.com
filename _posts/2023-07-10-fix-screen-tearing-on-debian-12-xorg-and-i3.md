---
title: "Fix screen tearing on Debian 12 Xorg and i3"
permalink: /fix-screen-tearing-on-debian-12-xorg-and-i3.html
date: 2023-07-10T04:21:48+02:00
layout: post
type: note
draft: false
---

I have been experiencing some issues with Intel® Integrated HD Graphics 3000
under Debian 12 with Xorg and i3. Using `picom` compositor didn't help. To fix
this issue create new file `/etc/X11/xorg.conf.d/20-intel.conf` as root and put
the following in the file.

```txt
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection
```

Reboot the system and that should be it.
