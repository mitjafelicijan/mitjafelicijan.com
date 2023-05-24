---
title: Write ISO to USB Key
url: write-iso-usb.html
date: 2023-05-08
type: notes
draft: false
---

Write ISO to USB key. Nothing fancy here.

```sh
sudo dd if=iso_file.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
```
