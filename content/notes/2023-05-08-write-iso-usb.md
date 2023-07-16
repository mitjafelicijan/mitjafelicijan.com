---
title: Write ISO to USB Key
url: write-iso-usb.html
date: 2023-05-08T12:00:00+02:00
type: note
draft: false
tags: [linux]
---

Write ISO to USB key. Nothing fancy here.

```sh
sudo dd if=iso_file.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
```

